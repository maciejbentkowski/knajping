class Admin::VenuesController < ApplicationController
    def destroy
        @venue = Venue.find(params[:id])
        @venue.destroy!

        render turbo_stream: turbo_stream.remove(helpers.dom_id(@venue, "admin"))
    end
end