class VenueProperty < ApplicationRecord
  belongs_to :venue
  belongs_to :property
end
