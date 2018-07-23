require "application_system_test_case"

class Users::BlocksTest < ApplicationSystemTestCase
  setup do
    @users_block = users_blocks(:one)
  end

  test "visiting the index" do
    visit users_blocks_url
    assert_selector "h1", text: "Users/Blocks"
  end

  test "creating a Block" do
    visit users_blocks_url
    click_on "New Users/Block"

    click_on "Create Block"

    assert_text "Block was successfully created"
    click_on "Back"
  end

  test "updating a Block" do
    visit users_blocks_url
    click_on "Edit", match: :first

    click_on "Update Block"

    assert_text "Block was successfully updated"
    click_on "Back"
  end

  test "destroying a Block" do
    visit users_blocks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Block was successfully destroyed"
  end
end
