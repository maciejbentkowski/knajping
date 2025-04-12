class NotificationsController < ApplicationController

    def index

        @notifications = current_user.notifications.includes(:event)
    end
end
