class Question < ApplicationRecord
    belongs_to :user
    belongs_to :venue, inverse_of: :questions
    has_many :answers, -> { order(created_at: :desc) }, inverse_of: :question, dependent: :destroy

    has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"

    validates :body, presence: true


    after_create { send_user_notification }

    private


    def send_user_notification
        return if user == venue.user
        notification = NewQuestionNotifier.with(
            record: self
        ).deliver(self.venue.user)
        broadcast_prepend_to "notifications_#{venue.user.id}",
                          target: "notifications_#{venue.user.id}",
                          partial: "notifications/notification",
                          locals: { notification: notification }
    end
end
