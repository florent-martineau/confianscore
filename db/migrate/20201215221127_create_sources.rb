class CreateSources < ActiveRecord::Migration[6.0]
  def change
    create_table :sources do |t|
      t.string :abstract
      t.string :link
      t.integer :person_id
      t.integer :value
      
      t.timestamps
    end
  end
end
