class Venue < ApplicationRecord
    after_initialize :set_activate_to_false, if: :new_record?
    belongs_to :user

    has_many :venue_venue_types, dependent: :destroy
    has_many :venue_types, through: :venue_venue_types
    has_many :reviews, dependent: :destroy

    validates :name, presence: true
    validates :is_activate, inclusion: { in: [ true, false ] }


    scope :active, -> { where(is_activate: true) }
    scope :inactive, -> { where(is_activate: false) }
    scope :recent, -> { active.order(created_at: :desc).limit(5) }

    def self.search(params)
        params[:query].blank? ? all : where(
            "lower(name) LIKE ?", "%#{sanitize_sql_like((params[:query]).downcase)}%"
        )
    end

    def update_avg_rating
        new_avg = calculate_avg_rating
        update_column(:avg_rating, new_avg)
    end

    def calculate_avg_rating
        if reviews.loaded?
          reviews.empty? ? 0 : (reviews.sum(&:avg_rating) / reviews.size.to_f).round(2)
        else
          reviews.average(:avg_rating)&.round(2) || 0
        end
    end

    def avg_venue_rating
        avg_rating.present? ? avg_rating : 0
    end

    def main_types(limit = 3)
        venue_venue_types.where("importance > 0")
                        .order(importance: :desc)
                        .limit(limit)
                        .includes(:venue_type)
                        .map(&:venue_type)
    end
      
    def side_types
        venue_venue_types.where(importance: 0)
                        .includes(:venue_type)
                        .map(&:venue_type)
    end
      
    def add_type(venue_type, importance = 0)
        venue_venue_types.find_or_create_by(venue_type: venue_type)
                        .update(importance: importance)
    end
      

    def add_main_type(venue_type, position = 1)
        position = [[position.to_i, 3].min, 1].max
        add_type(venue_type, position)
    end
      
    def add_side_type(venue_type)
        add_type(venue_type, 0)
    end

    private

    def set_activate_to_false
        self.is_activate ||= false
    end
end
