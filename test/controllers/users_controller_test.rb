# frozen_string_literal: true

require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:doncan)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    new_user = User.new(email: "new_user@gmail.com", full_name: "New User", username: "new_user")
    assert_difference("User.count") do
      post users_url, params: {user: {bio: new_user.bio, email: new_user.email, full_name: new_user.full_name, username: new_user.username}}
    end

    assert_redirected_to users_url
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: {user: {bio: @user.bio, email: @user.email, full_name: @user.full_name, username: @user.username}}
    assert_redirected_to users_url
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
