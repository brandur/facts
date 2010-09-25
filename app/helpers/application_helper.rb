include Facts::Application.routes.url_helpers

module ApplicationHelper
  def append_to_html(html, content)
    html.gsub /^(.*)(<.*?>)$/, "\\1#{content}\\2"
  end

  def category_path(category, use_slug = true)
    if use_slug
      "/#{category.slug}"
    else
      super.category_path(category)
    end
  end
end
