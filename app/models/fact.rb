require 'lib/database_helper'
require 'rdiscount'

class Fact < ActiveRecord::Base
  extend DatabaseHelper

  belongs_to :category
  validates_presence_of :category, :content

  scope :random, order(db_random)
  scope :search, lambda { |query|
    where 'facts.id LIKE ? OR facts.content LIKE ?', "%#{query}%", "%#{query}%"
  }

  def content_html
    RDiscount.new(content).to_html
  end

  def to_json
    json = { :fact => {
      :id => id, :category_id => category_id, :content => content
    } }
    json[:fact][:category] = category.to_json if category.loaded?
    json
  end
end

