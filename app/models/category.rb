class Category < ActiveRecord::Base
  acts_as_tree :foreign_key => :category_id, :order => :name

  has_many :facts

  validates_presence_of :name, :slug
  validates_uniqueness_of :slug

  before_validation :build_slug

  default_scope :order => :name
  scope :root, where(:category_id => nil)

  private

  def build_slug
    return if name.nil?
    parent.build_slug unless parent.nil? or not parent.slug.nil?
    self.slug = if not parent.nil? then parent.slug + "/" else "" end
    self.slug += name.downcase.gsub(/[^a-z0-9_ ]+/, "").gsub(/[ _]/, "-")
  end
end

