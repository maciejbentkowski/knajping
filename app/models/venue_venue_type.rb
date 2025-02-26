class VenueVenueType < ApplicationRecord
  belongs_to :venue
  belongs_to :venue_type

  validates :importance, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 3 }
  validates :venue_id, uniqueness: { scope: :venue_type_id, message: "already has this type assigned" }
end
