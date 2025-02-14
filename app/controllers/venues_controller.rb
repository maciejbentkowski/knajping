class VenuesController < ApplicationController
    before_action :set_venue, only: [:show]
    authorize_resource

    def index
        @venues = Venue.all
    end

    def show

    end


    private
    def current_ability
        @current_ability ||= VenueAbility.new(current_user)
    end

    def set_venue
        @venue = Venue.find(params[:id])
    end
end
