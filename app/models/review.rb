class Review < ApplicationRecord
    belongs_to :user
    belongs_to :venue

    has_one :rating, dependent: :destroy, inverse_of: :review
    accepts_nested_attributes_for :rating

    validates_associated :rating
    validates :title, presence: true
    validates :content, presence: true

    scope :recent, -> { order(created_at: :desc).limit(10) }
end
