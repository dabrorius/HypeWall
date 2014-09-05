require 'rails_helper'

RSpec.describe Admin::DashboardController, :type => :controller do
  context "default user" do
    let(:user) {FactoryGirl.create :user}

    before { get :index }

    it "should redirect to root" do
     expect(response).to render_template("landing")
    end
  end  
end