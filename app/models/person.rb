class Person < ApplicationRecord
    attr_accessor :id, :first_name, :last_name, :gender, :age, :birthdate

    def initialize(args = [])
        @id         = "No information available"
        @first_name = "No information available"
        @last_name  = "No information available"
        @gender     = "No information available"
        @age        = "No information available"
        @birthdate  = "No information available"
    end

    def to_s()
        return "id: " + @id.to_s() + "\nFirst Name: " + @first_name + \
            "\nLast Name: " + @last_name + "\nGender: " + @gender + "\nAge: " + @age + "\nBirthdate: " + @birthdate
    end
end
