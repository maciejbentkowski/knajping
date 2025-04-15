# To deliver this notification:
#
# NewAnswerNotifier.with(record: @post, message: "New post").deliver(User.all)

class NewAnswerNotifier < ApplicationNotifier
  notification_methods do
    def answer
      record
    end

    def date
      answer.created_at.strftime("%d/%m/%Y - %H:%M")
    end

    def venue
      answer&.question&.venue
    end

    def message
      "Nowe odpowiedź od #{answer&.user&.username} na twoje pytanie w obiekcie "
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
