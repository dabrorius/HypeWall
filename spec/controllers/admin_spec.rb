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

    before do
      sign_in user
      get :index
    end

    it "should redirect to root" do
     expect(response).to redirect_to(root_path)
    end
  end

  context "admin" do

    let(:admin) { FactoryGirl.create :user, :admin }

    before do
      sign_in admin
      get :index
    end

    it "should redirect to root" do
     expect(response.status).to eq(200)
    end
  end

end

