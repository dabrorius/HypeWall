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
      expect(response).to redirect_to(root_path)
    end

    it "can't see walls#new" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't see walls#edit" do
      get :edit, id: wall
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't see walls#control" do
      get :control, id: wall
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

    it "can't do walls#remove_background" do
      delete :remove_background, id: wall
      expect(response).to redirect_to(new_user_session_path)
    end

    it "can't do walls#remove_logo" do
      delete :remove_logo, id: wall
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "signed in user" do
    let(:owner) { FactoryGirl.create :user }
    let(:user) { FactoryGirl.create :user }
    let(:wall) { FactoryGirl.create :wall }

    before do
      sign_in user
      owner.walls << wall
    end

    it "can see walls#index" do
      get :index
      expect(response).to render_template("index")
    end

    it "can't see other persons walls#show" do
      get :show, id: wall
      expect(response).to redirect_to(root_path)
    end

    it "can't see other persons walls#edit" do
      get :edit, id: wall
      expect(response).to redirect_to(root_path)
    end

    it "can't see other persons walls#control" do
      get :control, id: wall
      expect(response).to redirect_to(root_path)
    end

    it "can't do other persons walls#update" do

      expect { put :update, id: wall, wall: { name: "New name" } }.
      to_not change { wall.reload.name }
      expect(response).to redirect_to(root_path)
    end

    it "can't do other persons walls#destroy" do
      delete :destroy, id: wall
      expect(response).to redirect_to(root_path)
    end

    it "can't do other persons walls#remove_background" do
      delete :remove_background, id: wall
      expect(response).to redirect_to(root_path)
    end

    it "can't do other persons walls#remove_logo" do
      delete :remove_logo, id: wall
      expect(response).to redirect_to(root_path)
    end
  end

  context "admin" do
    let(:owner) { FactoryGirl.create :user }
    let(:admin) { FactoryGirl.create :user, :admin }
    let(:wall) { FactoryGirl.create :wall }

    before do
      sign_in admin
      owner.walls << wall
    end


    it "can see walls#index" do
      get :index
      expect(response).to render_template("index")
    end

    it "can see other persons walls#show" do
      get :show, id: wall
      expect(response).to render_template("show")
    end

    it "can see other persons walls#edit" do
      get :edit, id: wall
      expect(response).to render_template("edit")
    end

    it "can see other persons walls#control" do
      get :control, id: wall
      expect(response).to render_template("control")
    end

    # perhaps better to use redirect_to, change destroy etc. too
    it "can do other persons walls#update" do
      put :update, id: wall, wall: { name: "New name" }
      expect(wall.reload.name).to eq "New name"
    end

    it "can do other persons walls#destroy" do
      delete :destroy, id: wall
      expect(response.status).to eq 302
    end

    it "can do other persons walls#remove_background" do
      delete :remove_background, id: wall
      expect(response.status).to eq 302
    end

    it "can do other persons walls#remove_logo" do
      delete :remove_logo, id: wall
      expect(response.status).to eq 302
    end

  end

end