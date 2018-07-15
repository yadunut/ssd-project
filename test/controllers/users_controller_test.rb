require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get profile" do
    get users_profile_url
    assert_response :success
  end

  test "should get settings" do
    get users_settings_url
    assert_response :success
  end

end
