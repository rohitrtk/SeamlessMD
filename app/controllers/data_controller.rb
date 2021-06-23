require 'rest-client'
require 'json'

# Key name constants
K_NAME       = "name"
K_FAMILY     = "family"
K_GIVEN      = "given"
K_GENDER     = "gender"
K_BIRTHDATE  = "birthDate"

class DataController < ApplicationController
    def index
        @title = "Data";
        get_data()
    end

    def get_data()
        puts "##### Getting Data! #####"

        response = RestClient.get("http://hapi.fhir.org/baseR4/Patient?_count=30&_pretty=true")

        entries = JSON.parse(response)["entry"]
        @num_patients = entries.length()
        
        # Patient array
        @patients = Array.new()

        for i in 1..30 do
            entry_res = entries[i-1]["resource"]
            
            puts "\n========== ITERATION ==========" + i.to_s()

            p = Person.new()

            # Get id
            p.id = entry_res["id"]
            puts p.id

            # Checking for name information
            if entry_res.has_key? K_NAME
                if entry_res[K_NAME][0].has_key? K_FAMILY
                    p.last_name = entry_res[K_NAME][0][K_FAMILY]
                end
                
                if entry_res[K_NAME][0].has_key? K_GIVEN
                    p.first_name = entry_res[K_NAME][0][K_GIVEN][0]
                end
            end

            # Checking for gender information
            if entry_res.has_key? K_GENDER
                p.gender = entry_res[K_GENDER]
            end

            # Checking for birthdate information
            if entry_res.has_key? K_BIRTHDATE
                p.birthdate = entry_res[K_BIRTHDATE][0, 10]
                p.age = `python agecalculator.py #{p.birthdate}`
            end

            puts p
            @patients.push(p)
        end
    end
end
