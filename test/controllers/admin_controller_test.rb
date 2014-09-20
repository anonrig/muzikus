require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get users" do
    get :users
    assert_response :success
  end

  test "should get budget" do
    get :budget
    assert_response :success
  end

end
