class VenuesController < ApplicationController
    authorize_resource

    def index
    end


    private


    def current_ability
        @current_ability ||= VenueAbility.new(current_user)
    end

end
