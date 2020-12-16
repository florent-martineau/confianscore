# == Schema Information
#
# Table name: votes
#
#  id           :bigint           not null, primary key
#  is_validated :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  source_id    :integer
#  tag_id       :integer
#

class Vote < ApplicationRecord
    belongs_to :source_id
    belongs_to :tag_id
end
