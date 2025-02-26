class PagesController < ApplicationController
    def main
        @featured_venues = Venue.active.sample(3)
        @reviews = Review.recent.includes(:venue, :user)
    end
end
