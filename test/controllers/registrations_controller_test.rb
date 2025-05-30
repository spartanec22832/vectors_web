require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should post create" do
    post registration_url, params: { email: "test@example.com", name: "User", password: "password" }
    assert_response :redirect
  end
end
