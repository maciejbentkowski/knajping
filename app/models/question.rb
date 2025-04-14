class Question < ApplicationRecord
    belongs_to :user
    belongs_to :venue, inverse_of: :questions
    has_many :answers, -> { order(created_at: :desc) }, inverse_of: :question, dependent: :destroy

    has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"

    validates :body, presence: true


    after_create { send_user_notification }

    private


    def send_user_notification
        return if user == self.venue.user
        
        NewQuestionNotifier.with(
            record: self
        ).deliver(self.venue.user)
    end
end
