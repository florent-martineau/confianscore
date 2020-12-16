class ChangeDataTypeForValueInSource < ActiveRecord::Migration[6.0]
  def change
    change_column :sources, :value, 'boolean USING CAST(value AS boolean)'
  end
end
