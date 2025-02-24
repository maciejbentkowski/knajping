module VenuesHelper
    def venue_ratings(venue)
        if venue.reviews.loaded? ? venue.reviews.size > 0 : venue.reviews.size > 0
            return "#{venue.avg_venue_rating} / 6 w #{venue.reviews.size} ocenach"
        else 
            return "Ten lokal nie ma jeszcze ocen"
        end
    end
end
