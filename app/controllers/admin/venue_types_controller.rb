class Admin::VenueTypesController < AdminController


    def edit
        @venue_type = VenueType.find(params[:id])
        render "admin/panel/venue_types/edit"
    end

   

    def update
        @venue_type = VenueType.find(params[:id])
        @venue_type.update!(venue_type_params)
        redirect_to admin_panel_index_path(value: "venue-types")
    end
    def destroy
        @venue_type = VenueType.find(params[:id])
        @venue_type.destroy!

        render turbo_stream: turbo_stream.remove(helpers.dom_id(@venue_type, "admin"))
    end

    private

    def venue_type_params
        params.require(:venue_type).permit(:name, :icon_name)
    end
end