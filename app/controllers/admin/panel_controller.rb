class Admin::PanelController < AdminController
    def index
        @menu_items = { "Venues" => "venues", "Venue Types" => "venue-types" } # changed : to => for proper string keys
        @value = params[:value]
        @collection =
          case @value
          when "venues"
            Venue.order(:name).includes(:user)
          when "venue-types"
            VenueType.all
          else
            []
          end
      end
end
