class Question < ApplicationRecord
    belongs_to :user
    belongs_to :venue

    validates :body, presence: true
end
