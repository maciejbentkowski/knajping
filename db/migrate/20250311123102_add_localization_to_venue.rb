class AddLocalizationToVenue < ActiveRecord::Migration[8.0]
  def change
    add_column :venues, :address, :string
    add_column :venues, :city, :string
    add_column :venues, :postal_code, :string
    add_column :venues, :latitude, :decimal, precision: 10, scale: 6
    add_column :venues, :longitude, :decimal, precision: 10, scale: 6

    add_index :venues, [:latitude, :longitude]
  end

end



