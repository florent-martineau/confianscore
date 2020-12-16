# == Schema Information
#
# Table name: scores
#
#  id              :bigint           not null, primary key
#  value           :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  person_id       :integer
#  point_verite_id :integer
#

class Score < ApplicationRecord
end
