class Review < ApplicationRecord

    belongs_to :user
    belongs_to :venue

    validates :title, presence: true
    validates :content, presence: true
end
