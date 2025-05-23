class VenueTypesController < ApplicationController
    def index
        @categories = VenueType.all
    end
end
