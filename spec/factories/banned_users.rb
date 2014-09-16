FactoryGirl.define do
	factory :banned_user do |f|
		f.user_id "123456"
		f.wall_id 123
		f.type "TwitterItem"
	end
end