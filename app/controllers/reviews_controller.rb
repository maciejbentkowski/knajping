class ReviewsController < ApplicationController
    authorize_resource

    def show
        @review = Review.find(params[:id])
    end

    def new
        @venue = Venue.find(params[:venue_id])
        @review = @venue.reviews.build
    end

    def create
        @venue = Venue.find(params[:venue_id])
        @review = @venue.reviews.build(review_params)
        @review.user = current_user

        if @review.save
            redirect_to review_path(@review)
        else
            flash[:alert] = "Nie udalo sie utworzyc oceny"
            redirect_to new_venue_review_path
        end
    end

    private
    def current_ability
        @current_ability ||= ReviewAbility.new(current_user)
    end

    def review_params
        params.require(:review).permit(:title, :content)
    end
end
