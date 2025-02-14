class PagesController < ApplicationController
    def main
        @venues = Venue.recent
    end
end
