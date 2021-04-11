# == Schema Information
#
# Table name: predictions
#
#  id                 :bigint           not null, primary key
#  abstract           :string
#  has_been_confirmed :boolean
#  justification      :string
#  link               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  person_id          :integer
#  user_id            :integer
#

class Prediction < ApplicationRecord
  belongs_to :person
end
