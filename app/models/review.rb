class Review < ApplicationRecord
    belongs_to :user
    belongs_to :venue

    has_one :rating, dependent: :destroy, inverse_of: :review
    accepts_nested_attributes_for :rating

    validates_associated :rating
    validates :title, presence: true
    validates :content, presence: true

    scope :recent, -> { order(created_at: :desc).limit(10) }

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
end
