class NotificationsController < ApplicationController
    def index
        @notifications = current_user&.notifications&.includes(event: [record: :user]).reverse
    end


    def destroy
        @notification = current_user.notifications.find(params[:id])
        @notification.destroy!
        render turbo_stream: turbo_stream.remove(helpers.dom_id(@notification))
    end
end
