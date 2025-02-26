class CreateVenueVenueTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :venue_venue_types do |t|
      t.references :venue, null: false, foreign_key: true
      t.references :venue_type, null: false, foreign_key: true
      t.integer :importance, default: 0
      
      t.timestamps
      
      t.index [:venue_id, :venue_type_id], unique: true
    end
  end
end
