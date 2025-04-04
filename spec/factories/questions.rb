FactoryBot.define do
  factory :question do
    sequence(:body) { |n| "Sample Body#{n}" }
    association :user
    association :venue
  end
end
