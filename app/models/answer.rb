class Answer < ApplicationRecord
    belongs_to :question, inverse_of: :answers, counter_cache: :count_of_answers
    belongs_to :user

    validates :body, presence: true


    has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"



    after_create { send_user_notification }

    private

    def send_user_notification
        return if user == question.user

        notification = NewAnswerNotifier.with(
            record: self
          ).deliver(self.question.user)

        notification = question.user.notifications.last    
        broadcast_prepend_to "notifications_#{question.user.id}",
                        target: "notifications_#{question.user.id}",
                        partial: "notifications/notification",
                        locals: { notification: notification }
    end
end
