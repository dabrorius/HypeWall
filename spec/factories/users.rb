FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@hypewall.io" }
    password         "password"
    password_confirmation "password"
  end
end