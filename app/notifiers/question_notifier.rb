# To deliver this notification:
#
# QuestionNotifier.with(record: @post, message: "New post").deliver(User.all)

class QuestionNotifier < ApplicationNotifier

  def message
    params[:message]
  end

end
