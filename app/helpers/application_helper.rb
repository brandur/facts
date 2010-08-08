include Facts::Application.routes.url_helpers

module ApplicationHelper
  def category_path(category)
    "#{categories_path}/#{category.slug}"
  end
end
