class Category < ActiveRecord::Base
  acts_as_tree :foreign_key => :category_id, :order => :name

  has_many :facts

  # Top-level category names cannot be only numerical
  validates_format_of :slug, :with => /[^0-9]/, :message => 'cannot be numerical at top-level'
  validates_presence_of :name, :slug
  validates_uniqueness_of :slug

  before_validation :build_slug

  default_scope :order => :name
  scope :top, where(:category_id => nil)
  scope :search, lambda { |query|
    where 'categories.id LIKE ? OR categories.name LIKE ?', "%#{query}%", "%#{query}%"
  }

  def to_json
    json = { :category => { :id => id, :name => name, :slug => slug, :parent_id => category_id } }
    json[:category][:facts] = facts.collect{ |f| f.to_json } if facts.loaded?
    json
  end

  private

  def build_slug
    return if name.nil?
    parent.build_slug unless parent.nil? or not parent.slug.nil?
    self.slug = if not parent.nil? then parent.slug + "/" else "" end
    self.slug += name.downcase.gsub(/[^a-z0-9_ ]+/, "").gsub(/[ _]/, "-")
  end
end

