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

require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
