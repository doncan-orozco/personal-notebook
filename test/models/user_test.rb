# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:doncan)
  end

  test "user is valid" do
    @user.valid?
  end

  test "user is invalid when email full_name and username are empty" do
    new_user = User.new

    errors_datails = {email: [{error: :blank}], full_name: [{error: :blank}], username: [{error: :blank}]}

    assert new_user.invalid?
    assert_equal errors_datails, new_user.errors.details
  end

  test "user is invalid when email is not unique" do
    new_user = User.new(email: @user.email, full_name: "New User", username: "new_user")

    errors_datails = {email: [{error: :taken, value: @user.email}]}

    assert new_user.invalid?
    assert_equal errors_datails, new_user.errors.details
  end
end
