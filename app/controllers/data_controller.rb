require 'rest-client'
require 'json'
require 'fhir_models'

# Key name constants.
K_NAME       = "name"
K_FAMILY     = "family"
K_GIVEN      = "given"
K_GENDER     = "gender"
K_BIRTHDATE  = "birthDate"

class DataController < ApplicationController
    
    # Called upon page load.
    # Sets the title name and then gets data.
    def index
        @title = "Data";
        get_data()
    end

    # Retrives the data from http://hapi.fhir.org/baseR4/Patient?_count=30&_pretty=true as a JSON
    # After retrival, calculate the total number of patients and then for each patient, create a Person and
    # find their id as well as their first name, last name, gender, and birthdate if that information is available.
    # If any information is unavailable, their person attribute will read as 'No information is available'.
    # if the birthdate is available, calculate their age (as of now, this is done via python) and then find
    # the average age of all patients.
    def get_data()
        puts "##### Getting Data! #####"

        # Get request.
        response = RestClient.get("http://hapi.fhir.org/baseR4/Patient?_count=30&_pretty=true")

        patients = FHIR.from_contents(response)

        # Get the number of entries which is equivalent to the number of patients.
        @num_patients = patients.entry.length()
        
        # We use patients_queried to calculate the average as not all patients have an age.
        # So instead of total_age / num_patients, we use total_age / patients_queried.
        @total_age = 0
        @patients_queried = 0

        # Patient array.
        @patients = Array.new()

        # For each patient, find their id, first name, last name, gender, birthdate, and age.
        for i in 0..29 do
            entry_res = patients.entry[i].resource
            
            puts "========== ITERATION " + i.to_s() + " =========="

            p = Person.new()

            # Set patient id.
            p.id = entry_res.id

            # Checking for name information
            if !entry_res.name[0].nil?

                # Take first given name in the array
                fn = entry_res.name[0].given[0]
                ln = entry_res.name[0].family

                if !fn.nil?
                    p.first_name = fn
                end

                if !ln.nil?
                    p.last_name = ln
                end
            end
            
            # Checking for gender information.
            if !entry_res.gender.nil?
                p.gender = entry_res.gender
            end

            # Checking for birthdate information.
            if !entry_res.birthDate.nil?
                p.birthdate = entry_res.birthDate
                p.age = `python agecalculator.py #{p.birthdate}`

                @total_age += p.age.to_f()
                @patients_queried += 1
            end

            puts p

            # Store the patient so the html can retrive patient information.
            @patients.push(p)
        end

        # Set the average age.
        @average_age = get_average_age()
    end

    # Returns the average age of all the patients with a birthdate.
    def get_average_age()
        return @patients_queried > 0 ? (@total_age / @patients_queried * 100).round / 100.0 : "No information available"
    end
end
