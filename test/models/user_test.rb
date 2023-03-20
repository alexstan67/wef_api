require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Correct user should save" do
    user = users(:john)
    assert user.save
  end

  test "email validation should trigger" do
    assert_not User.new(password: "123456", first_name: "First name", last_name: "Last Name").save
  end

  test "Too short password should not save" do
    assert_not User.new(email: "test@test.com", first_name: "First name", last_name: "Last Name", password: "123").save
  end
end
