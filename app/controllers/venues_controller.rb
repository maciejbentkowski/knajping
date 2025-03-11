class VenuesController < ApplicationController
    before_action :set_venue, only: [ :show, :edit, :update ]
    before_action :set_venue_types, only: [ :new, :edit, :create, :update ]
    load_and_authorize_resource

    def index
        @venues = Venue.active.includes(:reviews, :primary_photo_attachment).includes(venue_venue_types: :venue_type).search(params)

        @pagy, @venues = pagy(@venues)
    end

    def show
        @venue_reviews = @venue.reviews.includes(:rating, :user, user: :avatar_attachment)
    end

    def new
        @venue = Venue.new()
    end

    def create
      @venue = Venue.new(venue_params)
      @venue.user = current_user

      if @venue.save
        process_venue_types

        redirect_to @venue, notice: "Lokal został pomyślnie utworzony."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @venue.update(venue_params)
        # Remove all existing venue types first
        @venue.venue_venue_types.destroy_all

        process_venue_types

        redirect_to @venue, notice: "Lokal został pomyślnie zaktualizowany."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private
    def current_ability
        @current_ability ||= VenueAbility.new(current_user)
    end

    def set_venue
        @venue = Venue.find(params[:id])
    end

    def set_venue_types
      @venue_types = VenueType.all
    end

    def venue_params
        params.require(:venue).permit(:name, :address, :city, :postal_code, :is_activate, :primary_photo)
    end

    def process_venue_types
      if params[:venue_types].present?
        params[:venue_types].each do |type_id, role|
          next if role.blank?

          venue_type = VenueType.find(type_id)

          case role
          when "main1"
            @venue.add_main_type(venue_type, 1)
          when "main2"
            @venue.add_main_type(venue_type, 2)
          when "main3"
            @venue.add_main_type(venue_type, 3)
          when "side"
            @venue.add_side_type(venue_type)
          end
        end
      end
    end
end
