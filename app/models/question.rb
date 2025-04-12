class Question < ApplicationRecord
    belongs_to :user
    belongs_to :venue
    has_many :answers, -> { order(created_at: :desc) }, dependent: :destroy

    has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"

    validates :body, presence: true


    after_commit { send_user_notification }

    private


    def send_user_notification
        return if user == venue.user
        message = "#{self.user.username} just asked a question in #{self.venue.name}"
        QuestionNotifier.with(message: message).deliver(venue.user)

    end
end
