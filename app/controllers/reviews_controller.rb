class ReviewsController < ApplicationController

    def show
        @review = Review.find(params[:id])
    end


    private
    def current_ability
        @current_ability ||= ReviewAbility.new(current_user)
    end
end
