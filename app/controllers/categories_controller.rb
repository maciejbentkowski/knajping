class CategoriesController < ApplicationController
    def index
        @categories = VenueType.all
    end
end
