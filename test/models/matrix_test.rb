require "test_helper"

if Object.const_defined?(:Matrix) &&
   !(Matrix < ActiveRecord::Base rescue false)
  Object.send(:remove_const, :Matrix)
end

load Rails.root.join("app/models/matrix.rb")

class MatrixTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(name: "matrixer", email: "matrix@example.com", password: "password")
    @data = [[1,2],[3,4]]
  end

  test "valid with matrix_data and user" do
    m = ::Matrix.new(user: @user, matrix_data: @data)
    assert m.valid?
  end

  test "invalid without matrix_data" do
    m = ::Matrix.new(user: @user, matrix_data: nil)
    refute m.valid?
    assert_includes m.errors[:matrix_data], "can't be blank"
  end

  test "invalid without user" do
    m = ::Matrix.new(matrix_data: @data)
    refute m.valid?
    assert_includes m.errors[:user], "must exist"
  end

  test "has many operations and nullifies on destroy" do
    m = ::Matrix.create!(user: @user, matrix_data: @data)
    op = Operation.create!(user: @user,
      operation_type: :determinant,
      result_data: {value: -2.0, inputs: @data},
      matrix: m
    )
    assert_equal m, op.matrix
    m.destroy
    op.reload
    assert_nil op.matrix_id
  end

  test "belongs to user association" do
    m = ::Matrix.create!(user: @user, matrix_data: @data)
    assert_equal @user, m.user
  end
end