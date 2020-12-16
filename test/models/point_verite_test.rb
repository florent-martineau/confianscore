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

require 'test_helper'

class PointVeriteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
