# == Schema Information
#
# Table name: sources
#
#  id         :bigint           not null, primary key
#  abstract   :string
#  link       :string
#  used       :boolean
#  value      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :integer
#

class Source < ApplicationRecord
    belongs_to :person
    has_many :votes
    
    scope :validated_by_person, -> (person_id)  { where(value: true, person_id: person_id) }
    scope :pending, -> { where(value: nil) }
    def is_valid?
        value == true
    end
end
