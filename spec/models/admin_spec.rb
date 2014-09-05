require 'rails_helper'

RSpec.describe Admin::DashboardController, :type => :controller do
  context "non signed in user" do
    #let(:user) {FactoryGirl.create :user}

    before { get :index }

    it "should redirect to root" do
     expect(response).to redirect_to(root_path)
    end
  end  
end