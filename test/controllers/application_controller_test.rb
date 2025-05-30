require "test_helper"

# Dummy controller to expose ApplicationController behavior for testing
class DummyController < ApplicationController
  def index
    render json: {
      current_user_id: current_user&.id,
      signed_in:      user_signed_in?
    }
  end
end

class ApplicationControllerTest < ActionController::TestCase
  setup do
    @routes = ActionDispatch::Routing::RouteSet.new
    @routes.draw do
      get 'dummy/index', to: 'dummy#index'
    end
  end
  tests DummyController

  setup do
    @user = User.create!(
      name:              "Alice",
      email:             "alice@example.com",
      password:          "password",
      password_confirmation: "password"
    )
  end

  test "current_user returns nil when nobody is signed in" do
    get :index
    json = JSON.parse(response.body)
    assert_nil json["current_user_id"]
    assert_equal false, json["signed_in"]
  end

  test "current_user returns the user when signed in" do
    session[:user_id] = @user.id
    get :index
    json = JSON.parse(response.body)
    assert_equal @user.id, json["current_user_id"]
    assert_equal true,      json["signed_in"]
  end

  test "user_signed_in? is false if session is invalid" do
    session[:user_id] = 0
    get :index
    json = JSON.parse(response.body)
    assert_nil json["current_user_id"]
    assert_equal false, json["signed_in"]
  end
end
