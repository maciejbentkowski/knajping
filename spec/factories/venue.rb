FactoryBot.define do
  factory :venue do
    sequence(:name) { |n| "Venue #{n}" }
    is_activate { true }
    association :user
    sequence(:address) { |n| "Sample address #{n}" }
    postal_code { "01-910" }
    city { "Warsaw" }
    latitude { rand(52.18..52.31) }
    longitude { rand(20.87..21.08) }
  end
end
