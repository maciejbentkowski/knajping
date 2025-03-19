FactoryBot.define do
  factory :rating do
    atmosphere_rating { 4 }
    availability_rating { 4 }
    quality_rating { 4 }
    service_rating { 4 }
    uniqueness_rating { 4 }
    value_rating { 4 }
    association :review

    trait :rating_with_5 do
      atmosphere_rating { 5 }
      availability_rating { 5 }
      quality_rating { 5 }
      service_rating { 5 }
      uniqueness_rating { 5 }
      value_rating { 5 }
      association :review
    end

    trait :random do
      atmosphere_rating { rand(1..6) }
      availability_rating { rand(1..6) }
      quality_rating { rand(1..6) }
      service_rating { rand(1..6) }
      uniqueness_rating { rand(1..6) }
      value_rating { rand(1..6) }
    end
  end
end
