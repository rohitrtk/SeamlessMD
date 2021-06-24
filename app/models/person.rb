# Useful information in FHIR -> entry - > resource
# id
# language
# name
# telecom
# gender
# birthDate
# deceasedBoolean
# deceasedDateTime
# address
# maritalStatus
class Person < ApplicationRecord
    attr_accessor :id, :first_name, :last_name, :gender, :age, :birthdate

    # Set all fields to 'No information available' as default.
    def initialize(args = [])
        @id         = "No information available"
        @first_name = "No information available"
        @last_name  = "No information available"
        @gender     = "No information available"
        @age        = "No information available"
        @birthdate  = "No information available"
    end

    # String override for debugging purposes.
    def to_s()
        return "id: " + @id.to_s() + "\nFirst Name: " + @first_name + \
            "\nLast Name: " + @last_name + "\nGender: " + @gender + "\nAge: " + @age + "\nBirthdate: " + @birthdate
    end
end
