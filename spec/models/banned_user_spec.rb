require 'rails_helper'

describe BannedUser do 
	it "has a valid factory" do
		expect(FactoryGirl.create(:banned_user)).to be_valid
	end

	it "is invalid without original user id" do
		expect(FactoryGirl.build(:banned_user, user_id: nil)).to_not be_valid
	end

	it "is invalid without wall id" do
		expect(FactoryGirl.build(:banned_user, wall_id: nil)).to_not be_valid
	end
end