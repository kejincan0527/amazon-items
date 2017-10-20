module ApplicationHelper
  def active_brands
    Brand.joins(:items).group("brands.id").having("count(items.id) > ?", 0)
  end

  def default_image
    "https://placehold.it/170x170"
  end
end
