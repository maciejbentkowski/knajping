class Venue < ApplicationRecord
    belongs_to :user

    validates :name, presence: true
    validates :is_activate, inclusion: { in: [ true, false ] }

    scope :active, -> { where(is_activate: true) }
    scope :inactive, -> { where(is_activate: false) }

    scope :recent, -> { order(created_at: :desc).limit(5) }
end
