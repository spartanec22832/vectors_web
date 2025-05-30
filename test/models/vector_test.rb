require "test_helper"

if Object.const_defined?(:Vector) &&
   !(Vector < ActiveRecord::Base rescue false)
  Object.send(:remove_const, :Vector)
end

load Rails.root.join("app/models/vector.rb")

class VectorTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(name: "tester", email: "test@example.com", password: "password")
  end

  test "valid with coords and user" do
    v = ::Vector.new(user: @user, coords: [1.0, 2.0, 3.0])
    assert v.valid?
  end

  test "invalid without coords" do
    v = ::Vector.new(user: @user, coords: nil)
    refute v.valid?
    assert_includes v.errors[:coords], "can't be blank"
  end

  test "invalid without user" do
    v = ::Vector.new(coords: [1,2])
    refute v.valid?
    assert_includes v.errors[:user], "must exist"
  end

  test "has many operations and nullifies on destroy" do
    v = ::Vector.create!(user: @user, coords: [0,0])
    op = Operation.create!(user: @user,
      operation_type: :dot_product,
      result_data: {value: 0, inputs: {v1: [0], v2: [0]}},
      vector: v
    )
    assert_equal v, op.vector
    v.destroy
    op.reload
    assert_nil op.vector_id
  end

  test "belongs to user association" do
    v = ::Vector.create!(user: @user, coords: [5])
    assert_equal @user, v.user
  end
end