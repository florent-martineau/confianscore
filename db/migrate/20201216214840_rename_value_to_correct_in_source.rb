class RenameValueToCorrectInSource < ActiveRecord::Migration[6.0]
  def change
    rename_column :sources, :value, :is_correct
  end
end
