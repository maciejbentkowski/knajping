module ApplicationHelper
    include Pagy::Frontend

    def avatar(current_user)
        if current_user&.avatar&.attached?
            image_tag(current_user.avatar.variant(resize_to_fill: [ 300, 300 ]), alt: "User avatar", class: "rounded-full ring-2 ring-white")
        else
            image_tag("default_avatar.png", alt: "User devault avatar", class: "rounded-full")
        end
    end

    def primary_photo(venue)
        if venue.primary_photo.attached?
            image_tag(venue.primary_photo.variant(resize_to_limit: [ 800, 400 ]).processed(), alt: "Venue primary photo", class: " rounded-md w-full h-full")
        else
            image_tag("default_primary_photo.jpg", alt: "Venue default primary photo", class: "rounded-md w-full h-full")
        end
    end
end
