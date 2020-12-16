class AddUsedToSource < ActiveRecord::Migration[6.0]
  def change
    add_column :sources, :used, :boolean
  end
end
