class AddNicknameToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :nickname, :string
  end
end
