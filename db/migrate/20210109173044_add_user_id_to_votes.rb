class AddUserIdToVotes < ActiveRecord::Migration[6.0]
  def change
    add_column :votes, :user_id, :integer
    add_column :votes, :points, :integer
    add_column :votes, :is_admin_vote, :boolean, default: false
  end
end
