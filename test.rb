require 'rest-client'
require 'json'

response = RestClient.get("http://hapi.fhir.org/baseR4/Patient?_count=30&_pretty=true")

ENTRIES = JSON.parse(response)["entry"]
num_entries = ENTRIES.length()

ENTRY_RES = ENTRIES[0]["resource"]

id = ENTRY_RES["id"]
puts id

last_name = ENTRY_RES["name"][0]["family"]
first_name = ENTRY_RES["name"][0]["given"][0]
puts(first_name + " " + last_name)

gender = ENTRY_RES["gender"]
puts(gender)

birthdate = ENTRY_RES["birthDate"][0, 10]
puts birthdate

age = `python agecalculator.py #{birthdate}`
puts age