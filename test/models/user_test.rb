require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "is valid" do
    subject = User.new(user_attributes)

    assert subject.valid?
  end

  test "is not valid" do
    subject = User.new(user_attributes(email: nil, password: nil))

    refute subject.valid?
    assert_equal 2, subject.errors.size
  end

  def user_attributes(attrs = {})
    {
      email: "doncan.orozco@gmail.com",
      password: "123qwe123"
    }.merge(attrs)
  end
end
