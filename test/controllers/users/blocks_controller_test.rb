require 'test_helper'

class Users::BlocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @users_block = users_blocks(:one)
  end

  test "should get index" do
    get users_blocks_url
    assert_response :success
  end

  test "should get new" do
    get new_users_block_url
    assert_response :success
  end

  test "should create users_block" do
    assert_difference('Users::Block.count') do
      post users_blocks_url, params: { users_block: {  } }
    end

    assert_redirected_to users_block_url(Users::Block.last)
  end

  test "should show users_block" do
    get users_block_url(@users_block)
    assert_response :success
  end

  test "should get edit" do
    get edit_users_block_url(@users_block)
    assert_response :success
  end

  test "should update users_block" do
    patch users_block_url(@users_block), params: { users_block: {  } }
    assert_redirected_to users_block_url(@users_block)
  end

  test "should destroy users_block" do
    assert_difference('Users::Block.count', -1) do
      delete users_block_url(@users_block)
    end

    assert_redirected_to users_blocks_url
  end
end
