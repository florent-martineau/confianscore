# == Schema Information
#
# Table name: commentaires
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  source_id  :integer
#

class Commentaire < ApplicationRecord
    belongs_to :source
end
