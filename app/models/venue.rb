class Venue < ApplicationRecord
    after_initialize :set_activate_to_false, if: :new_record?
    belongs_to :user

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

    private

    def set_activate_to_false
        self.is_activate ||= false
    end
end
