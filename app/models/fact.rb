require 'rdiscount'

class Fact < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :category, :content

  def content_html
    RDiscount.new(content).to_html
  end
end

