# == Schema Information
#
# Table name: people
#
#  id             :bigint           not null, primary key
#  first_name     :string
#  last_name      :string
#  media          :json
#  wiki_summary   :string
#  wikipedia_link :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
