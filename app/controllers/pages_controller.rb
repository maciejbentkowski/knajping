class PagesController < ApplicationController
    def main
        @featured_venues = Venue.featured_venues
        @recent_reviews = Review.with_active_venue.recent_3.includes(:venue, :user, :rating, user: :avatar_attachment)
        @four_random_categories = VenueType.order("RANDOM()").limit(4)
    end

    def profile
        @profile = current_user
        @user_reviews = Review.where(user: @profile).includes(:venue, :rating)
        @user_venues = Venue.where(user: @profile)
    end
end
