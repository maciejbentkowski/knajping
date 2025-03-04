module ApplicationHelper
    include Pagy::Frontend

    def avatar(current_user)
        if current_user.avatar.attached?
            image_tag(current_user.avatar, alt: "User avatar", class: "rounded-full")
        else
            image_tag("default_avatar.png", alt: "User devault avatar", class: "rounded-full")
        end
    end

    def primary_photo(venue)
        if venue.primary_photo.attached?
            image_tag(venue.primary_photo, alt: "Venue primary photo", class: "w-full h-full object-cover")
        else

            image_tag("default_primary_photo.jpg", alt: "Venue default primary photo", class: "w-full h-full object-cover")
        end
    end
end
