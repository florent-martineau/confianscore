class AddValueToScore < ActiveRecord::Migration[6.0]
  def change
    add_column :scores, :value, :float
  end
end
