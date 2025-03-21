class ReviewsController < ApplicationController
    load_and_authorize_resource

    def index
        @reviews = Review.with_active_venue.includes(:venue, :user, :rating, user: :avatar_attachment)
        @pagy, @reviews = pagy(@reviews, limit: 9)
    end
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
            @review.build_rating
        end
    end

    def create
        @venue = Venue.find(params[:venue_id])
        @review = @venue.reviews.build(review_params)
        @review.user = current_user

        if @review.save
            redirect_to review_path(@review)
        else
            @review.build_rating unless @review.rating
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @review = Review.find(params[:id])
        @review.build_rating unless @review.rating
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
        params.require(:review).permit(
          :content,
          rating_attributes: [
            :atmosphere_rating,
            :availability_rating,
            :quality_rating,
            :service_rating,
            :uniqueness_rating,
            :value_rating
          ]
        )
      end
end
