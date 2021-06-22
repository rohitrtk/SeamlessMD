require 'rest-client'
require 'json'

# Key name constants
KEYS_NAME       = "name"
KEYS_FAMILY     = "family"
KEYS_GIVEN      = "given"
KEYS_GENDER     = "gender"
KEYS_BIRTHDATE  = "birthDate"

response = RestClient.get("http://hapi.fhir.org/baseR4/Patient?_count=30&_pretty=true")

ENTRIES = JSON.parse(response)["entry"]
num_entries = ENTRIES.length()

ENTRY_RES = ENTRIES[0]["resource"]

# Get id
id = ENTRY_RES["id"]
puts id

# Checking for name information
if ENTRY_RES.has_key? KEYS_NAME
    if ENTRY_RES[KEYS_NAME][0].has_key? KEYS_FAMILY
        last_name = ENTRY_RES[KEYS_NAME][0][KEYS_FAMILY]
        puts last_name
    else
        puts "No last name information available."
    end
    
    if ENTRY_RES[KEYS_NAME][0].has_key? KEYS_GIVEN
        first_name = ENTRY_RES[KEYS_NAME][0][KEYS_GIVEN][0]
        puts(first_name + " " + last_name)
    else
        puts "No first name information available."
    end

else
    puts "No name information available."
end

# Checking for gender information
if ENTRY_RES.has_key? KEYS_GENDER
    gender = ENTRY_RES[KEYS_GENDER]
    puts(gender)
else
    puts "No gender information available."
end

# Checking for birthdate information
if ENTRY_RES.has_key? KEYS_BIRTHDATE
    birthdate = ENTRY_RES[KEYS_BIRTHDATE][0, 10]
    puts birthdate

    age = `python agecalculator.py #{birthdate}`
    puts age
else
    puts "No birthdate information available."
end