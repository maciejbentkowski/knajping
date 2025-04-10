class Question < ApplicationRecord
    belongs_to :user
    belongs_to :venue
    has_many :answers, -> { order(created_at: :desc) }, dependent: :destroy

    validates :body, presence: true
end
