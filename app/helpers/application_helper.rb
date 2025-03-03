module ApplicationHelper
    include Pagy::Frontend

    def avatar(current_user)
        if current_user.avatar.attached?
            image_tag(current_user.avatar, alt: 'User Profile', class:"rounded-full")
        else
            image_tag("default_avatar.png", alt: 'User Profile', class:"rounded-full")
        end
    end
end
