class Review < ApplicationRecord
    belongs_to :user
    belongs_to :venue

    validates :title, presence: true
    validates :content, presence: true

    scope :recent, -> { order(created_at: :desc).limit(10) }
end
