require "test_helper"

class OperationTest < ActiveSupport::TestCase
  test "valid operation" do
    user = User.create!(name: "Test User", email: "test@example.com", password: "password123")
    operation = Operation.new(operation_type: "determinant", user: user)
    assert operation.valid?
  end

  test "invalid without operation_type" do
    operation = Operation.new
    assert_not operation.valid?
  end
  test "belongs to user" do
    assoc = Operation.reflect_on_association(:user)
    assert_equal :belongs_to, assoc.macro
  end
  test "enum operation_type" do
    assert_equal ["determinant", "dot_product", "cross_product"], Operation.operation_types.keys
  end
  test "operation without matrix and vector is valid" do
    user = User.create!(name: "Test User", email: "test@example.com", password: "password123")
    operation = Operation.new(operation_type: "determinant", user: user)
    assert operation.valid?
  end


end
