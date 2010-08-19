require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_session" do
    post :create, :user_session => { :login => 'rand', :password => 'stone-of-tears9' }
    assert user_session = UserSession.find
    assert_equal users(:rand), user_session.user
    assert_redirected_to user_path(user_session.user)
  end

  test "should destroy user_session" do
    delete :destroy
    assert_nil UserSession.find
    assert_redirected_to new_user_session_path
  end
end
