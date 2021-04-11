class CreatePredictions < ActiveRecord::Migration[6.0]
  def change
    create_table :predictions do |t|
      t.string :abstract
      t.string :justification
      t.boolean :has_been_confirmed
      t.string :link
      t.integer :user_id
      t.integer :person_id

      t.timestamps
    end
  end
end
