require "test_helper"

[:Vector, :Matrix].each do |const|
  if Object.const_defined?(const) &&
     !(Object.const_get(const) < ActiveRecord::Base rescue false)
    Object.send(:remove_const, const)
  end
end

load Rails.root.join("app/models/vector.rb")
load Rails.root.join("app/models/matrix.rb")

class VectorCalculatorServiceTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(
      name: "test_user",
      email: "user@example.com",
      password: "password"
    )
  end

  test "calculates determinant and records operation and audit_log" do
    params = { operation: "determinant", matrix: "1 2\n3 4" }
    result = VectorCalculatorService.new(@user, params).call

    assert_in_delta -2.0, result, 1e-8

    op  = Operation.order(:created_at).last
    log = AuditLog.order(:created_at).last

    assert_equal @user, op.user
    assert_equal "determinant", op.operation_type
    assert_equal [[1.0,2.0],[3.0,4.0]], op.result_data["inputs"]

    assert_equal @user, log.user
    assert_equal "operation", log.event_type
    
  end

  test "calculates dot product and records operation and audit_log" do
    params = { operation: "dot", vector1: "1 2 3", vector2: "4 5 6" }
    result = VectorCalculatorService.new(@user, params).call

    assert_equal 32.0, result

    op  = Operation.order(:created_at).last
    log = AuditLog.order(:created_at).last

    assert_equal "dot_product", op.operation_type
    assert_equal [1.0,2.0,3.0], op.result_data["inputs"]["v1"]
    assert_equal [4.0,5.0,6.0], op.result_data["inputs"]["v2"]
    assert_equal "operation", log.event_type
  end

  test "calculates cross product and records operation and audit_log" do
    params = { operation: "cross", vector1: "1 0 0", vector2: "0 1 0" }
    result = VectorCalculatorService.new(@user, params).call

    assert_equal [0.0,0.0,1.0], result

    op = Operation.order(:created_at).last
    assert_equal "cross_product", op.operation_type
  end

  test "raises if matrix param missing for determinant" do
    err = assert_raises(ArgumentError) do
      VectorCalculatorService.new(@user,
        operation: "determinant", matrix: ""
      ).call
    end
    assert_match /matrix.*не должно быть пустым/i, err.message
  end

  test "raises if matrix contains invalid element" do
    err = assert_raises(ArgumentError) do
      VectorCalculatorService.new(@user,
        operation: "determinant", matrix: "1 a\n2 3"
      ).call
    end
    assert_match /Неправильный элемент «a»/, err.message
  end

  test "raises if vector1 or vector2 missing for dot and cross" do
    %w[dot cross].each do |op|
      err1 = assert_raises(ArgumentError) do
        VectorCalculatorService.new(@user,
          operation: op, vector1: "", vector2: "1 2"
        ).call
      end
      assert_match /vector1.*не должно быть пустым/i, err1.message

      err2 = assert_raises(ArgumentError) do
        VectorCalculatorService.new(@user,
          operation: op, vector1: "1 2", vector2: ""
        ).call
      end
      assert_match /vector2.*не должно быть пустым/i, err2.message
    end
  end

  test "raises if vector has invalid element" do
    %w[dot cross].each do |op|
      err = assert_raises(ArgumentError) do
        VectorCalculatorService.new(@user,
          operation: op, vector1: "1 b", vector2: "0 1"
        ).call
      end
      assert_match /Неправильный элемент «b»/, err.message
    end
  end
end
