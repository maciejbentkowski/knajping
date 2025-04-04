FactoryBot.define do
  factory :answer do
      sequence(:body) { |n| "Sample Body#{n}" }
      association :user
      association :question
  end
end
