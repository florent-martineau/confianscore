class AddPhotoUrlToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :photo_url, :string
  end
end
