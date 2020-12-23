# == Schema Information
#
# Table name: searches
#
#  id         :bigint           not null, primary key
#  keywords   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :integer
#

class Search < ApplicationRecord
end
