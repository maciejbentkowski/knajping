class Admin::PanelController < AdminController
    def index
        @menu_items = { "Users" => "users", "Venues" => "venues", "Venue Types" => "venue-types", "Reviews" => "reviews" }
        @value = params[:value]
        @collection =
          case @value
          when "users"
            User.all
          when "venues"
            Venue.order(:name).includes(:user)
          when "venue-types"
            VenueType.all
          when "reviews"
            Review.all.includes(:user, :venue, :rating)
          else
            []
          end
      end
end
