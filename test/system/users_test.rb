require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @user2 = users(:wemail)
    @user3 = users(:wpassword)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  # test "creating a User" do
  #   visit users_url
  #   click_on "New User"

  #   fill_in "Email", with: @user.email
  #   fill_in "Name", with: @user.name
  #   fill_in "Password digest", with: @user.password_digest
  #   click_on "Create User"

  #   assert_text "User was successfully created"
  #   click_on "Back"
  # end

  # test "updating a User" do
  #   visit users_url
  #   click_on "Edit", match: :first

  #   fill_in "Email", with: @user.email
  #   fill_in "Name", with: @user.name
  #   fill_in "Password digest", with: @user.password_digest
  #   click_on "Update User"

  #   assert_text "User was successfully updated"
  #   click_on "Back"
  # end

  test "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Please login."
  end
  test "register user" do
    visit main_url
    click_on "Sign up"
    fill_in "Email", with: "aaa"
    fill_in "Name", with: "aaa"
    fill_in "Password", with: BCrypt::Password.create("aaa")
    click_on "Create User"
    assert_text "User was successfully created"
  end

  test "login with right person" do
    visit main_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: "zzz"
    click_on "Login"
    assert_text "UTwitter"
  end

  test "login with wrong email" do
    visit main_url
    fill_in "Email", with: "jjj"
    fill_in "Password", with: @user2.password_digest
    click_on "Login"
    assert_text "Not found this user"
  end

  test "login with wrong password" do
    visit main_url
    fill_in "Email", with: @user3.email
    fill_in "Password", with: BCrypt::Password.create("zzz")
    click_on "Login"
    assert_text "Wrong password"
  end

  test "like system" do
    visit main_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: "zzz"
    click_on "Login"
    click_on "Create Post"
    fill_in "Msg", with: "aaaaaaa"
    click_on "Create Post"
    click_on "Like" , match: :first
    click_on "Like: 1" , match: :first
    assert_text "zzz"
  end


end
