class VenueType < ApplicationRecord
    has_many :venue_venue_types, dependent: :destroy
    has_many :venues, through: :venue_venue_types
end
