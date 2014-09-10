require 'rails_helper'

RSpec.describe WallsController, :type => :controller do

  context "non signed in user" do

    let(:wall) { FactoryGirl.create :wall }

    it "can't see walls#index" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't see walls#show" do
      get :show, id: wall
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't see walls#new" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't see walls#edit" do
      get :edit, id: wall
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't do walls#create" do
      post :create, id: wall
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't do walls#update" do
      put :update, id: wall
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't do walls#destroy" do
      delete :destroy, id: wall
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "signed in user" do
    let!(:owner) { FactoryGirl.create :user }
    let(:user) { FactoryGirl.create :user }
    let(:wall) { FactoryGirl.create :wall }

    before { owner.walls << wall }

    it "can't see other persons walls#index" do
      get :index
      expect(response.status).to eq(404)

    end

  end
end