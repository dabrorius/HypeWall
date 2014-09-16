require 'test_helper'

class WallsControllerTest < ActionController::TestCase
  setup do
    @wall = walls(:one)
    @item = items(:one)
    @banned_user = banned_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:walls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wall" do
    assert_difference('Wall.count') do
      post :create, wall: { description: @wall.description, hashtag: @wall.hashtag, name: @wall.name }
    end

    assert_redirected_to wall_path(assigns(:wall))
  end

  test "should show wall" do
    get :show, id: @wall
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wall
    assert_response :success
  end

  test "should update wall" do
    patch :update, id: @wall, wall: { description: @wall.description, hashtag: @wall.hashtag, name: @wall.name }
    assert_redirected_to wall_path(assigns(:wall))
  end

  test "should destroy wall" do
    assert_difference('Wall.count', -1) do
      delete :destroy, id: @wall
    end

    assert_redirected_to walls_path
  end

  test "should ban user" do 
    assert_difference('BannedUser.count') do
      get :ban_user, id: @item.id
    end
  end

  test "should unban user" do 
    assert_difference('BannedUser.count', -1) do
      get :unban_user, id: @banned_user
    end
  end

  test "should list banned users" do
    get :list_banned_users
    assert_response :success
  end
end
