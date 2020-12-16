# == Schema Information
#
# Table name: point_verites
#
#  id         :bigint           not null, primary key
#  value      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :integer
#

class PointVerite < ApplicationRecord
    after_create :compute_new_score

    def compute_new_score
        score_value = (0.25*value*value) + (0.5*value) + 0.25
        Score.create(person_id: person_id, value: score_value)
    end
end
