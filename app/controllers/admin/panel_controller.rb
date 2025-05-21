class Admin::PanelController < AdminController
    def index
        @menu_items = { "Users" => "users", "Venues" => "venues", "Venue Types" => "venue-types" } # changed : to => for proper string keys
        @value = params[:value]
        @collection =
          case @value
          when "users"
            User.all
          when "venues"
            Venue.order(:name).includes(:user)
          when "venue-types"
            VenueType.all
          else
            []
          end
      end
end
