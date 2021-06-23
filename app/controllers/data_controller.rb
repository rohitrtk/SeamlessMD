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
        num_entries = entries.length()

        entry_res = entries[0]["resource"]

        # Get id
        id = entry_res["id"]
        puts id

        # Checking for name information
        if entry_res.has_key? K_NAME
            if entry_res[K_NAME][0].has_key? K_FAMILY
                last_name = entry_res[K_NAME][0][K_FAMILY]
                puts last_name
            else
                puts "No last name information available."
            end
            
            if entry_res[K_NAME][0].has_key? K_GIVEN
                first_name = entry_res[K_NAME][0][K_GIVEN][0]
                puts(first_name + " " + last_name)
            else
                puts "No first name information available."
            end

        else
            puts "No name information available."
        end

        # Checking for gender information
        if entry_res.has_key? K_GENDER
            gender = entry_res[K_GENDER]
            puts(gender)
        else
            puts "No gender information available."
        end

        # Checking for birthdate information
        if entry_res.has_key? K_BIRTHDATE
            birthdate = entry_res[K_BIRTHDATE][0, 10]
            puts birthdate

            age = `python agecalculator.py #{birthdate}`
            puts age
        else
            puts "No birthdate information available."
        end
    end
end
