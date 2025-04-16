# To deliver this notification:
#
# QuestionNotifier.with(record: @post, message: "New post").deliver(User.all)

class NewQuestionNotifier < ApplicationNotifier
  notification_methods do
    def question
      record
    end

    def date
      question.created_at.strftime("%d/%m/%Y - %H:%M")
    end

    def venue
      question&.venue
    end

    def message
      "Nowe pytanie od #{question&.user&.username} w obiekcie "
    end

    def path
      if venue.present?
        Rails.application.routes.url_helpers.venue_path(venue)
      else
        Rails.application.routes.url_helpers.root_path
      end
    end
  end
end
