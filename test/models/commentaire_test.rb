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

require 'test_helper'

class CommentaireTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
