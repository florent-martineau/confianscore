class AddAdminStatusToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin_status, :boolean, default: false
    add_column :users, :points, :integer, default: 0
  end
end
