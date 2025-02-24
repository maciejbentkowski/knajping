FactoryBot.define do
  factory :review do
    association :venue
    association :user
    sequence(:title) { |n| "Sample Title #{n}" }
    sequence(:content) { |n| "Sample Content#{n}" }

    after(:build) do |review|
      review.rating ||= build(:rating, review: review)
    end
  end
end
