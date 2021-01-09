# == Schema Information
#
# Table name: votes
#
#  id            :bigint           not null, primary key
#  is_admin_vote :boolean          default(FALSE)
#  is_validated  :boolean
#  points        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  source_id     :integer
#  tag_id        :integer
#  user_id       :integer
#

require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
