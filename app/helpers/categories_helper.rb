module CategoriesHelper
  def count_str(category)
    if category.children.count > 0 && category.facts.count > 0
      "#{pluralize(category.facts.count, 'fact')}, #{pluralize(category.children.count, 'category')}"
    elsif category.facts.count > 0
      "#{pluralize(category.facts.count, 'fact')}"
    elsif category.children.count > 0
      "#{pluralize(category.children.count, 'category')}"
    else
      'empty'
    end
  end
end
