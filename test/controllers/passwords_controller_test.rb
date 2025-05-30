require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get reset" do
    get password_reset_new_url
    assert_response :success
  end
end
