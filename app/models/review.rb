class Review < ApplicationRecord
    belongs_to :user
    belongs_to :venue

    has_one :rating, dependent: :destroy, inverse_of: :review
    accepts_nested_attributes_for :rating

    validates_associated :rating
    validates :content, presence: true

    scope :recent, -> { order(created_at: :desc).limit(3) }
    scope :with_active_venue, -> { joins(:venue).where(venues: { is_activate: true }) }
    after_commit :update_venue_avg_rating, on: [ :create, :update, :destroy ]

    def rating_dictionary
        rating_dictionary = {}
        rating_dictionary["Wartość"] = self.rating.value_rating
        rating_dictionary["Serwis"] = self.rating.service_rating
        rating_dictionary["Atmosfera"] = self.rating.atmosphere_rating
        rating_dictionary["Jakość"] = self.rating.quality_rating
        rating_dictionary["Dostępność"] = self.rating.availability_rating
        rating_dictionary["Unikalność"] = self.rating.uniqueness_rating

        rating_dictionary
    end

    def avg_rating
        return 0 unless rating
        rating.avg_rating
    end

    private

    def update_venue_avg_rating
        venue.update_avg_rating
    end
end
