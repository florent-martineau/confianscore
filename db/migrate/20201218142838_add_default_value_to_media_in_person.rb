class AddDefaultValueToMediaInPerson < ActiveRecord::Migration[6.0]
  def change
    change_column :people, :media, :json, :default => {}
  end
end
