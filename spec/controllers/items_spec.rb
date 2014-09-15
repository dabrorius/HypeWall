require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do
  context "when wall and item pending approval with attachment exist" do
    let(:wall) { FactoryGirl.create :wall }
    let!(:item) { FactoryGirl.create :item, wall: wall, status: "pending_approval" }
    let(:attachment) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/fake.jpg", "image/jpg") }

    context "non signed in user" do

      it "can't do item#approve" do
        xhr :get, :approve, id: item
        expect(item.reload.status).to eq "pending_approval"
        # ajax request doesn't need a redirect
        expect(response.status).to eq 401
      end

      it "can't do item#ban" do
        xhr :get, :ban, id: item
        expect(item.reload.status).to eq "pending_approval"
        expect(response.status).to eq 401
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
        xhr :get, :approve, id: item
        expect(item.reload.status).to eq "pending_approval"
        expect(response).to redirect_to(root_path)
      end

      it "can't do item#ban" do
        xhr :get, :ban, id: item
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

    context "owner" do
      let(:owner) { FactoryGirl.create :user }
      before do
        sign_in owner
        owner.walls << wall
      end

      it "can do item#approve" do
        xhr :get, :approve, id: item
        expect(item.reload.status).to eq "approved"
        expect(response).to render_template("change_status")
      end

      it "can do item#ban" do
        xhr :get, :ban, id: item
        expect(item.reload.status).to eq "banned"
        expect(response).to render_template("change_status")
      end

      it "can do item#new" do
        get :new, id: wall.id
        expect(response).to render_template("new")
      end

      it "can do item#create", :pending => true do
        expect { post :create, id: wall.id, images_attributes: [attachment: attachment] }.
        to change{ UploadedImage.count }.from(0).to(1)
        expect(response).to redirect_to control_wall_path(wall)
      end
    end

    context "admin" do
      let(:admin) { FactoryGirl.create :user, :admin }

      before do
        sign_in admin
      end

      it "can do item#approve" do
        xhr :get, :approve, id: item
        expect(item.reload.status).to eq "approved"
        expect(response).to render_template("change_status")
      end

      it "can do item#ban" do
        xhr :get, :ban, id: item
        expect(item.reload.status).to eq "banned"
        expect(response).to render_template("change_status")
      end

      it "can do item#new" do
        get :new, id: wall.slug
        expect(response).to render_template("new")
      end

      it "can do item#create", :pending => true do
        expect { post :create, id: wall.id, images_attributes: [attachment: attachment] }.
        to change{ UploadedImage.count }.from(0).to(1)
        expect(response).to redirect_to control_wall_path(wall)
      end
    end

  end
end
