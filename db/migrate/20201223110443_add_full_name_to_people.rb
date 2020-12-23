class AddFullNameToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :full_name, :string
  end
end
