require 'rails_helper'

RSpec.describe WallsController, :type => :controller do

  context "when wall exists" do
    let(:wall) { FactoryGirl.create :wall }

    context "non signed in user" do

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

<<<<<<< HEAD
      it "can't see other persons walls#history" do
        get :history, id: wall
        expect(response).to redirect_to(new_user_session_path)
      end

=======
>>>>>>> bcae0463d6b766e1763a2c734742d9f25a7c81e4
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

<<<<<<< HEAD
      it "can't see other persons walls#history" do
        get :history, id: wall
        expect(response).to redirect_to(root_path)
      end

=======
>>>>>>> bcae0463d6b766e1763a2c734742d9f25a7c81e4
      it "can't do other persons walls#update" do
        expect { put :update, id: wall, wall: { name: "New name" } }.
        to_not change { wall.reload.name }
        expect(response).to redirect_to(root_path)
      end

      it "can't do other persons walls#destroy" do
        delete :destroy, id: wall
        expect(wall.reload).to be
        expect(response).to redirect_to(root_path)
      end

      it "can't do other persons walls#remove_background" do
        delete :remove_background, id: wall
        expect(wall.reload.background_image_file_name).not_to be_blank
        expect(response).to redirect_to(root_path)
      end

      it "can't do other persons walls#remove_logo" do
        delete :remove_logo, id: wall
        expect(wall.reload.logo_file_name).not_to be_blank
        expect(response).to redirect_to(root_path)
      end
    end

    context "owner" do
      let(:owner) { FactoryGirl.create :user }

      before do
        sign_in owner
        owner.walls << wall
      end

      it "can see walls#index" do
        get :index
        expect(response).to render_template("index")
      end

<<<<<<< HEAD
      it "can see walls#show" do
=======
      it "can see other persons walls#show" do
>>>>>>> bcae0463d6b766e1763a2c734742d9f25a7c81e4
        get :show, id: wall
        expect(response).to render_template("show")
      end

<<<<<<< HEAD
      it "can see walls#edit" do
=======
      it "can see other persons walls#edit" do
>>>>>>> bcae0463d6b766e1763a2c734742d9f25a7c81e4
        get :edit, id: wall
        expect(response).to render_template("edit")
      end

<<<<<<< HEAD
      it "can see walls#control" do
=======
      it "can see other persons walls#control" do
>>>>>>> bcae0463d6b766e1763a2c734742d9f25a7c81e4
        get :control, id: wall
        expect(response).to render_template("control")
      end

<<<<<<< HEAD
      it "can see walls#history" do
        get :history, id: wall
        expect(response).to render_template("history")
      end

      it "can do walls#update" do
=======
      it "can do other persons walls#update" do
>>>>>>> bcae0463d6b766e1763a2c734742d9f25a7c81e4
        put :update, id: wall, wall: { name: "New name" }
        expect(wall.reload.name).to eq "New name"
        expect(response).to redirect_to edit_wall_path(wall)
      end

<<<<<<< HEAD
      it "can do walls#destroy" do
=======
      it "can do other persons walls#destroy" do
>>>>>>> bcae0463d6b766e1763a2c734742d9f25a7c81e4
        expect { delete :destroy, id: wall }.
        to change{ Wall.count }.from(1).to(0)
        expect(response).to redirect_to walls_path
      end

<<<<<<< HEAD
      it "can do walls#remove_background" do
=======
      it "can do other persons walls#remove_background" do
>>>>>>> bcae0463d6b766e1763a2c734742d9f25a7c81e4
        delete :remove_background, id: wall
        expect(wall.reload.background_image_file_name).to be_blank
        expect(response).to redirect_to edit_wall_path(wall)
      end

<<<<<<< HEAD
      it "can do walls#remove_logo" do
=======
      it "can do other persons walls#remove_logo" do
>>>>>>> bcae0463d6b766e1763a2c734742d9f25a7c81e4
        delete :remove_logo, id: wall
        expect(wall.reload.logo_file_name).to be_blank
        expect(response).to redirect_to edit_wall_path(wall)
      end
    end

    context "admin" do
      let(:owner) { FactoryGirl.create :user }
      let(:admin) { FactoryGirl.create :user, :admin }

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

<<<<<<< HEAD
      it "can see other persons walls#history" do
        get :history, id: wall
        expect(response).to render_template("history")
      end

=======
>>>>>>> bcae0463d6b766e1763a2c734742d9f25a7c81e4
      it "can do other persons walls#update" do
        put :update, id: wall, wall: { name: "New name" }
        expect(wall.reload.name).to eq "New name"
        expect(response).to redirect_to edit_wall_path(wall)
      end

      it "can do other persons walls#destroy" do
        expect { delete :destroy, id: wall }.
        to change{ Wall.count }.from(1).to(0)
        expect(response).to redirect_to walls_path
      end

      it "can do other persons walls#remove_background" do
        delete :remove_background, id: wall
        expect(wall.reload.background_image_file_name).to be_blank
        expect(response).to redirect_to edit_wall_path(wall)
      end

      it "can do other persons walls#remove_logo" do
        delete :remove_logo, id: wall
        expect(wall.reload.logo_file_name).to be_blank
        expect(response).to redirect_to edit_wall_path(wall)
      end
    end


  end
end
