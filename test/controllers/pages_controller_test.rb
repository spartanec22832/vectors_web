require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
  end

  test "should get profile" do
    get profile_page_url
    assert_response :success
  end

  test "should get support" do
    get support_page_url
    assert_response :success
  end

  test "should get history" do
    get history_page_url
    assert_response :success
  end
end
