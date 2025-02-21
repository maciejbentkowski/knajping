class ReviewsController < ApplicationController
    load_and_authorize_resource

    def show
        @review = Review.find(params[:id])
    end

    def new
        @venue = Venue.find(params[:venue_id])
        existing_review = @venue.reviews.find_by(user: current_user)

        if existing_review
            redirect_to edit_review_path(existing_review)
        else
            @review = @venue.reviews.build
        end
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

    def edit
        @review = Review.find(params[:id])
        @venue = @review.venue
    end

    def update
        if @review.update(review_params)
            redirect_to review_path(@review), notice: "Review was successfully updated."
        else
            render :edit, status: :unprocessable_entity
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
