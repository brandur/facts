include Facts::Application.routes.url_helpers

module ApplicationHelper
  def category_path(category, use_slug = true)
    if use_slug
      "#{categories_path}/#{category.slug}"
    else
      super.category_path(category)
    end
  end
end
