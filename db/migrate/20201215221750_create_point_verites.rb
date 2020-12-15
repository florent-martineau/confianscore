class CreatePointVerites < ActiveRecord::Migration[6.0]
  def change
    create_table :point_verites do |t|
      t.integer :person_id
      t.float :value

      t.timestamps
    end
  end
end
