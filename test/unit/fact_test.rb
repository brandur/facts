require 'test_helper'

class FactTest < ActiveSupport::TestCase
  fixtures :categories

  test "should make its markdown content accessible as HTML" do
    f = Fact.create :content => "_emphasized_"
    assert f.content_html.include? "<em>emphasized</em>"
  end

  test "should validate presence of a category" do
    f = Fact.create :content => "science is an art form"
    assert f.invalid?
    f.category = categories(:science)
    assert f.valid?
  end

  test "should validate presence of content" do
    f = Fact.create :category => categories(:world)
    assert f.invalid?
    f.content = "the world is a big place"
    assert f.valid?
  end

  test "should perform search" do
    facts = Fact.search "meter"
    assert_equal 3, facts.count
  end
end
