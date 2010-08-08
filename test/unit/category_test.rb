require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "should validate presence of name" do
    c = Category.create
    assert c.invalid?
    c.name = "Cities of the World"
    assert c.valid?
  end

  test "should build slug" do
    c = Category.create :name => "Cities of the World"
    assert c.valid?
    assert_equal "cities-of-the-world", c.slug
  end

  test "should build slug based on parent" do
    c1 = Category.create :name => "Geography"
    c2 = Category.create :name => "Cities of the World", :parent => c1
    assert c2.valid?
    assert_equal "geography/cities-of-the-world", c2.slug
  end

  test "should have slug after save" do
    c = Category.create :name => "Cities of the World"
    c.save
    assert c.slug
  end
end
