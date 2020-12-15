class Person < ApplicationRecord
    has_many :sources
    
    def full_name
        first_name + " " + last_name
    end
end
