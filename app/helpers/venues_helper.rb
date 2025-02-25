module VenuesHelper
    def venue_ratings(venue)
        if venue.reviews.loaded? ? venue.reviews.size > 0 : venue.reviews.size > 0
            "(#{venue.avg_venue_rating} / 6) w #{venue.reviews.size} ocenach"
        else
            "Ten lokal nie ma jeszcze ocen"
        end
    end
end
