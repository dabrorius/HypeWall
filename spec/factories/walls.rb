FactoryGirl.define do
  factory :wall do
    sequence(:name) {|n| "Wall #{n}" }
    sequence(:hashtag) { |n| "hashtag#{n}" }
    sequence(:background_image_file_name) { |n| "image_name#{n}"}
    sequence(:logo_file_name) { |n| "logo_name#{n}"}
  end
end
