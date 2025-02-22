class Rating < ApplicationRecord
    belongs_to :review

    validates :atmosphere_rating,
            presence: true,
            numericality: { only_integer: true },
            inclusion: { in: 1..6 }

    validates :availability_rating,
            presence: true,
            numericality: { only_integer: true },
            inclusion: { in: 1..6 }

    validates :quality_rating,
            presence: true,
            numericality: { only_integer: true },
            inclusion: { in: 1..6 }

    validates :service_rating,
            presence: true,
            numericality: { only_integer: true },
            inclusion: { in: 1..6 }

    validates :uniqueness_rating,
            presence: true,
            numericality: { only_integer: true },
            inclusion: { in: 1..6 }

    validates :value_rating,
            presence: true,
            numericality: { only_integer: true },
            inclusion: { in: 1..6 }

end
