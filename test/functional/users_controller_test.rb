require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:rand)
  end

# commented out until we put in a mechanism to create new users
=begin
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => { :login => 'gimli', :password => 'and-my-axe!', :password_confirmation => 'and-my-axe!'}
    end

    assert_redirected_to user_path(assigns(:user))
  end
=end

  test "should show user" do
    get :show, :id => @user.to_param
    assert_response :success
  end

  test "should get edit" do
    UserSession.create(@user)
    get :edit, :id => @user.to_param
    assert_response :success
  end

  test "should update user" do
    UserSession.create(@user)
    put :update, :id => @user.to_param, :user => @user.attributes
    assert_redirected_to user_path(assigns(:user))
  end
end
