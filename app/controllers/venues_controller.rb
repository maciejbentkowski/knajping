class VenuesController < ApplicationController
    authorize_resource

    def index
        @venues = Venue.all
    end


    private

    def current_ability
        @current_ability ||= VenueAbility.new(current_user)
    end
end
