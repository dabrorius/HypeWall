FactoryGirl.define do
  factory :wall do
    sequence(:name) {|n| "Wall #{n}" }
  end
end
