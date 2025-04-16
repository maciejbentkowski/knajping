# To deliver this notification:
#
# NewReviewNotifier.with(record: @post, message: "New post").deliver(User.all)

class NewReviewNotifier < ApplicationNotifier
  notification_methods do
    def review
      record
    end

    def date
      review.created_at.strftime("%d/%m/%Y - %H:%M")
    end

    def venue
      review&.venue
    end

    def message
      "Nowe recenzja od #{review&.user&.username} w obiekcie "
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
