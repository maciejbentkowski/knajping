class Answer < ApplicationRecord
    belongs_to :question, counter_cache: :count_of_answers
    belongs_to :user

    validates :body, presence: true
end
