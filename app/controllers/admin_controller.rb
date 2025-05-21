class AdminController < ApplicationController
    before_action :authorized?
    private
    def authorized?
      unless current_user&.admin?
        flash[:alert] = "You are not authorized to view that page."
        redirect_to root_path
      end
    end
end
