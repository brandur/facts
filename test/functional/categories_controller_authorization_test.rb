require 'test_helper'

class CategoriesControllerAuthorizationTest < ActionController::TestCase
  tests CategoriesController

  setup do
    @category = categories(:perimeter)
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
