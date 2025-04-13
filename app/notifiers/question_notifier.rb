# To deliver this notification:
#
# QuestionNotifier.with(record: @post, message: "New post").deliver(User.all)

class QuestionNotifier < ApplicationNotifier
  def record
    params[:record]
  end

  def message
    params[:message]
  end

  def venue
    params[:venue]
  end

  def path
    if venue.present?
      Rails.application.routes.url_helpers.venue_path(venue)
    else
      Rails.application.routes.url_helpers.root_path
    end
  end
end
