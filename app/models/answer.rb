class Answer < ApplicationRecord
    belongs_to :question, inverse_of: :answers, counter_cache: :count_of_answers
    belongs_to :user

    validates :body, presence: true


    has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"



    after_commit { send_user_notification }

    private

    def send_user_notification
        return if user == question.user
        message = "#{self.user.username} just answer your question in #{self.question.venue.name}"
        AnswerNotifier.with(
            message: message,
            record: self,
            venue: self.question.venue
          ).deliver(self.question.user)
    end
end
