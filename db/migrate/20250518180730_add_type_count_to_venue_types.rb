class AddTypeCountToVenueTypes < ActiveRecord::Migration[8.0]
  def change
    add_column :venue_types, :types_count, :integer, default: 0, null: false
  end
end
