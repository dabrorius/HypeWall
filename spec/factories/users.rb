FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@hypewall.io" }
    password "password"
    password_confirmation "password"

    trait :admin do
      is_admin true
    end
  end
end