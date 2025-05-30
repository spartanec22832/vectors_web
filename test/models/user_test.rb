require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = User.new(name: "Test User", email: "test@example.com", password: "password123")
    assert user.valid?
  end

  test "invalid without name" do
    user = User.new(email: "test@example.com", password: "password123")
    assert_not user.valid?
  end

  test "invalid without email" do
    user = User.new(name: "Test User", password: "password123")
    assert_not user.valid?
  end

  test "invalid without password" do
    user = User.new(name: "Test User", email: "test@example.com")
    assert_not user.valid?
  end

  test "unique email" do
    User.create!(name: "User1", email: "test@example.com", password: "password123")
    user2 = User.new(name: "User2", email: "test@example.com", password: "password123")
    assert_not user2.valid?
  end
end
