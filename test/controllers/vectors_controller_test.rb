require "test_helper"

class VectorsControllerTest < ActionDispatch::IntegrationTest
  test "should calculate vector" do
    post vector_calculate_url, params: { vector: [1, 2, 3] }
    assert_response :success
  end
end
