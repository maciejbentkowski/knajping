class ReviewsController < ApplicationController


    private
    def current_ability
        @current_ability ||= ReviewAbility.new(current_user)
    end
end
