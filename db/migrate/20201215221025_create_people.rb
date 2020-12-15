class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :wikipedia_link
      t.json :media
      t.string :wiki_summary

      t.timestamps
    end
  end
end
