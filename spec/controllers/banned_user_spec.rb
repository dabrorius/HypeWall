RSpec.describe WallsController do

	describe "ban user" do
		it "creates new banned user" do
			item = FactoryGirl.create(:item)
			expect{
				post :ban_user, id: "bla", item_id: item, banned_user: FactoryGirl.attributes_for(:banned_user)
			}.to change(BannedUser, :count).by(1)
		end	
	end
end