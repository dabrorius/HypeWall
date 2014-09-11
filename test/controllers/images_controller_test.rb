require 'test_helper'

class ImagesControllerTest < ActionController::TestCase
  test "should get approve" do
    get :approve
    assert_response :success
  end

  test "should get ban" do
    get :ban
    assert_response :success
  end

end
