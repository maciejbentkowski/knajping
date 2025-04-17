class CreateVenueProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :venue_properties do |t|
      t.references :venue, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
