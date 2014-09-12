require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do
  context "when wall and item pending approval exist" do
    let(:wall) { FactoryGirl.create :wall }
    let(:item) { FactoryGirl.create :item, status: "pending_approval" }

    context "non signed in user" do

      it "can't do item#approve" do
        get :approve, id: item
        expect(item.reload.status).to eq "pending_approval"
        expect(response).to redirect_to(new_user_session_path)
      end

      it "can't do item#ban" do
        get :ban, id: item
        expect(item.reload.status).to eq "pending_approval"
        expect(response).to redirect_to(new_user_session_path)
      end

      it "can't do item#new" do
        get :new, id: wall.slug
        expect(response).to redirect_to(new_user_session_path)
      end

      it "can't do item#create" do
        post :create, id: wall.slug
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "signed in user" do
      let(:user) { FactoryGirl.create :user }
      before { sign_in user }

      it "can't do item#approve" do
        get :approve, id: item
        expect(item.reload.status).to eq "pending_approval"
        expect(response).to redirect_to(root_path)
      end

      it "can't do item#ban" do
        get :ban, id: item
        expect(item.reload.status).to eq "pending_approval"
        expect(response).to redirect_to(root_path)
      end

      it "can't do item#new" do
        get :new, id: wall.slug
        expect(response).to redirect_to(root_path)
      end

      it "can't do item#create" do
        post :create, id: wall.slug
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
