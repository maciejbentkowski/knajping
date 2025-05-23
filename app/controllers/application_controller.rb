class ApplicationController < ActionController::Base
  include Pagy::Backend
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from CanCan::AccessDenied do |exception|
    if exception.action == :new && current_user == nil
      respond_to do |format|
        format.json { head :forbidden }
        format.html { redirect_to new_user_session_path, alert: exception.message }
      end
    else
      respond_to do |format|
        format.json { head :forbidden }
        format.html { redirect_to root_path, alert: exception.message }
      end
    end
  end
end
