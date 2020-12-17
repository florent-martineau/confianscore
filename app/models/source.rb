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

    scope :validated_and_used_by_person, -> (person_id)  { where(is_correct: true, person_id: person_id, used: true) }
    scope :pending, -> { where(is_correct: nil) }
    
    def self.new_pendings
        Source.pending.first(10)
    end
    
    def is_valid?
        is_correct == true
    end

    def score
        coefficients = self.votes.map {|vote| vote.tag.coefficient}
        average_coefficient = ((coefficients.inject{ |sum, el| sum + el }.to_f) / coefficients.size)

        counts = Hash.new(0)
        coefficients.each { |coefficient| counts[coefficient] += 1 }
        maxi = counts.values.max
        coefficients_most_represented = []
        counts.each do |k, v|
            coefficients_most_represented << k if v == maxi
        end

        coefficients_most_represented << average_coefficient
        (coefficients_most_represented.inject(0){|sum,x| sum + x } / coefficients_most_represented.count).to_f
    end

    def abstract_with_name
        "« " + abstract + " » - " + person.full_name
    end
end