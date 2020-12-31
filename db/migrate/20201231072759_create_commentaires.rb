class CreateCommentaires < ActiveRecord::Migration[6.0]
  def change
    create_table :commentaires do |t|
      t.integer :source_id
      t.text :content

      t.timestamps
    end
  end
end
