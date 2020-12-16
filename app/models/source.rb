class Source < ApplicationRecord
    belongs_to :person

    def is_valid?
        value == true
    end
end
