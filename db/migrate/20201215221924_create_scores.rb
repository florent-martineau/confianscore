class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.integer :person_id
      t.integer :point_verite_id

      t.timestamps
    end
  end
end
