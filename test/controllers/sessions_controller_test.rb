require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should login and redirect" do
    User.create!(name: "Test", email: "test@example.com", password: "password123")
    post login_url, params: { email: "test@example.com", password: "password123" }
    assert_response :redirect
  end

  test "should logout and redirect" do

    user = User.create!(name: "Test", email: "test@example.com", password: "password123")
    post login_url, params: { email: "test@example.com", password: "password123" }
    assert_response :redirect


    delete logout_url
    assert_response :redirect
  end
end
