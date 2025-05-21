class Admin::VenueTypesController < VenueTypesController
    def destroy
        @venue_type = VenueType.find(params[:id])
        @venue_type.destroy!

        render turbo_stream: turbo_stream.remove(helpers.dom_id(@venue_type, "admin"))
    end
end