class NotificationsController < ApplicationController
    def index
        if current_user
            current_user.notifications.mark_as_seen
            @notifications = current_user&.notifications&.includes(event: [ record: :user ]).newest_first
        end
    end


    def destroy
        @notification = current_user.notifications.find(params[:id])
        @notification.destroy!
        render turbo_stream: turbo_stream.remove("notification_#{@notification.id}")
    end

    def mark_as_read
        @notification = current_user.notifications.find(params[:id])
        @notification.mark_as_read
        render turbo_stream: turbo_stream.replace(helpers.dom_id(@notification))
    end
end
