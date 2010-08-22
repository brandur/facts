require 'test_helper'

class CategoriesControllerAuthorizationTest < ActionController::TestCase
  tests CategoriesController

  setup do
    @category = categories(:perimeter)
  end

  test "should be able to create category with params login" do
    @category.name = 'Category Created with Params Login'

    assert_difference('Category.count') do
      encode_http_credentials
      post :create, :category => @category.attributes, :format => 'json'
    end

    assert_response :created
  end

  test "should not be able to create category with bad params login" do
    @category.name = 'Category Created with Bad Params Login'

    assert_no_difference('Category.count') do
      encode_http_credentials 'rand', 'bad-pass'
      post :create, :category => @category.attributes, :format => 'json'
    end

    assert_response :unauthorized
  end

  test "should not be able to create category without login" do
    @category.name = 'This Category is not Going In'

    assert_no_difference('Category.count') do
      post :create, :category => @category.attributes
    end
  end

  test "should not be able to update another user's category" do
    UserSession.create(users(:mat))
    put :update, :id => @category.to_param, :category => @category.attributes
    assert_redirected_to categories_path
  end

  test "should not be able to destroy another user's category" do
    UserSession.create(users(:mat))

    assert_no_difference('Category.count') do
      delete :destroy, :id => @category.to_param
    end

    assert_redirected_to categories_path
  end

  test "should not be able to use another user's category as parent" do
    UserSession.create(users(:mat))

    category = Category.new :name => 'Area'
    category.parent = @category

    assert_no_difference('Category.count') do
      post :create, :category => category.attributes
    end

    assert_redirected_to categories_path
  end
end
