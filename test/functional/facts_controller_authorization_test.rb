require 'test_helper'

class FactsControllerAuthorizationTest < ActionController::TestCase
  tests FactsController

  setup do
    @fact = facts(:cubism_one)
  end

  test "should be able to create fact with params login" do
    @fact.content = 'Fact created with params login'

    assert_difference('Fact.count') do
      encode_http_credentials
      post :create, :fact => @fact.attributes, :format => :json
    end

    assert_response :created
  end

  test "should not be able to create fact with bad params login" do
    @fact.content = 'Fact created with bad params login'

    assert_no_difference('Fact.count') do
      encode_http_credentials 'rand', 'bad-pass'
      post :create, :fact => @fact.attributes, :format => :json
    end

    assert_response :unauthorized
  end

  test "should not be able to create fact without login" do
    @fact.content = 'No fact can be created without a login'

    assert_no_difference('Fact.count') do
      post :create, :fact => @fact.attributes
    end
  end

  test "should not be able to update another user's fact" do
    UserSession.create(users(:mat))
    put :update, :id => @fact.to_param, :fact => @fact.attributes
    assert_redirected_to categories_path
  end

  test "should not be able to destroy another user's fact" do
    UserSession.create(users(:mat))

    assert_no_difference('Fact.count') do
      delete :destroy, :id => @fact.to_param
    end

    assert_redirected_to categories_path
  end

  test "should not be able to use another user's category" do
    UserSession.create(users(:mat))

    fact = Fact.new :content => "Mat's fact"
    fact.category = categories(:perimeter)

    assert_no_difference('Fact.count') do
      post :create, :fact => fact.attributes
    end

    assert_redirected_to categories_path
  end
end
