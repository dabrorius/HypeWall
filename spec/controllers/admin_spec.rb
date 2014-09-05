require 'rails_helper'



RSpec.describe Admin::DashboardController, :type => :controller do
  context "non signed in user" do
    before { get :index }

    it "should redirect to root" do
     expect(response).to redirect_to(root_path)
    end
  end  

  context "regular user" do

    let(:user) { FactoryGirl.create :user }

    #user.confirm!
    before do
      sign_in user
      get :index
    end
    
    it "should redirect to root" do
     expect(response).to redirect_to(root_path)
    end
  end

  context "admin" do

    let(:user) { FactoryGirl.create :user, is_admin: true }
    
    before do
      sign_in user
      get :index
    end
    
    it "should redirect to root" do
     expect(response.status).to eq(200)
    end
  end

end

