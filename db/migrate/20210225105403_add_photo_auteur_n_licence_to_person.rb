class AddPhotoAuteurNLicenceToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :photo_auteur, :string
    add_column :people, :photo_licence, :string
  end
end
