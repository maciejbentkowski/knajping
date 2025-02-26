class AddAvgRatingToVenues < ActiveRecord::Migration[8.0]
  def change
    add_column :venues, :avg_rating, :decimal, precision: 3, scale: 2, default: 0
  end
end
