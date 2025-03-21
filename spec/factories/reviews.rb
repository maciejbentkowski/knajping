FactoryBot.define do
  factory :review do
    association :venue
    association :user
    sequence(:content) { |n| "Sample Content#{n}" }

    trait :with_rating_five do
      after(:build) do |review|
        review.rating = build(:rating, :rating_with_5, review: review)
      end
    end

    after(:build) do |review|
      review.rating ||= build(:rating, review: review)
    end
  end
end
