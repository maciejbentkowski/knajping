class VenuesController < ApplicationController
    before_action :set_venue, only: [ :show, :edit, :update ]
    load_and_authorize_resource

    def index
        @venues = Venue.active.search(params)

        @pagy, @venues = pagy(@venues)
    end

    def show
    end

    def new
        @venue = Venue.new()
    end

    def create
        @venue = Venue.new(venue_params.merge(user_id: current_user.id))

        if @venue.save
            redirect_to venue_path(@venue)
        else
            flash[:alert] = "Nie udalo sie utworzyc lokalu"
            redirect_to new_venue_path
        end
    end

    def edit
    end

    def update
        @venue.update(venue_params)
        redirect_to(venue_path(@venue))
    end

    private
    def current_ability
        @current_ability ||= VenueAbility.new(current_user)
    end

    def set_venue
        @venue = Venue.find(params[:id])
    end

    def venue_params
        params.require(:venue).permit(:name, :is_activate)
    end
end
