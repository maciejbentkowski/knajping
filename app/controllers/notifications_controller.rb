class NotificationsController < ApplicationController
    after_action :mark_notifications_as_seen, only: [ :index ]

    def index
        if current_user
            @notifications = current_user&.notifications&.includes(event: [ record: [ :user, :venue ] ]).newest_first
        end
    end


    def destroy
        @notification = current_user.notifications.find(params[:id])
        @notification.destroy!
        current_user.update_notifications_quantity
        render turbo_stream: turbo_stream.remove(helpers.dom_id(@notification))
    end

    def mark_as_read
        @notification = current_user.notifications.find(params[:id])
        @notification.mark_as_read
        @notification.mark_as_seen
        current_user.update_notifications_quantity
        render turbo_stream: turbo_stream.replace(
            helpers.dom_id(@notification),
            partial: "notifications/notification",
            locals: { notification: @notification })
    end

    private

    def mark_notifications_as_seen
        current_user.notifications.mark_as_seen
    end
end
