require 'test_helper'

class Users::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get users_users_search_url
    assert_response :success
  end

  test "should get profile" do
    get users_users_profile_url
    assert_response :success
  end

end
