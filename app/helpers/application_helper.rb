include Facts::Application.routes.url_helpers

module ApplicationHelper
  def show_category_path(category)
    "#{categories_path}/#{category.slug}"
  end
  #def category_path(*args)
    #unsanitize_slashes(super(args))
  #end

  private

  # Rails has some issues with over-aggressive escaping, so use this method to 
  # replace escaped slashes with unescaped ones.
  def unsanitize_slashes(str)
    str.gsub /%2F/, '/'
  end
end
