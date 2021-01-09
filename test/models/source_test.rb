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
#  user_id    :integer
#

require 'test_helper'

class SourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
