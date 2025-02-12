FactoryBot.define do
    factory :venue do
      sequence(:name) { |n| "Venue #{n}" }
      is_activate { true }
      association :user
  
    end
  end