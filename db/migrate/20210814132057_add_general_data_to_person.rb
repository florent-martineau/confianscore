class AddGeneralDataToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :general_data, :json
  end
end
