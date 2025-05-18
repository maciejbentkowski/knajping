class AddIconToVenueType < ActiveRecord::Migration[8.0]
  def change
    add_column :venue_types, :icon_name, :string
  end
end
