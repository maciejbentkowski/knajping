# To deliver this notification:
#
# AnswerNotifier.with(record: @post, message: "New post").deliver(User.all)

class AnswerNotifier < ApplicationNotifier
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
