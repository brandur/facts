require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should show about page" do
    get :about
    assert_response :success
  end
end
