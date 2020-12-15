class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :source_id
      t.boolean :is_validated
      t.integer :tag_id

      t.timestamps
    end
  end
end
