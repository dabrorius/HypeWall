FactoryGirl.define do
  factory :wall do
    sequence(:name) {|n| "Wall #{n}" }
    sequence(:hashtag) { |n| "hashtag#{n}"}
  end
end
