# == Schema Information
#
# Table name: sources
#
#  id         :bigint           not null, primary key
#  abstract   :string
#  is_correct :boolean
#  link       :string
#  used       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :integer
#

class Source < ApplicationRecord
    VOTES_REQUIRED = 1
    VALIDATED_PCT = 0.8

    belongs_to :person
    has_many :votes

    scope :validated_by_person, -> (person_id)  { where(is_correct: true, person_id: person_id) }
    scope :pending, -> { where(is_correct: nil) }
    
    def self.new_pendings
        Source.pending.first(10)
    end
    
    def is_valid?
        is_correct == true
    end

    def score
        coefficients = self.votes.map {|vote| vote.tag.coefficient}
        ((coefficients.inject{ |sum, el| sum + el }.to_f) / coefficients.size)
    end

    def abstract_with_name
        "« " + abstract + " » - " + person.full_name
    end
end