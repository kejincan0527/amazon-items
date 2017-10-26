class Item < ApplicationRecord
  belongs_to :brand

  def wrapped_image
    wrap_image = "https://placehold.it/170x170"
    if main_image != nil && main_image.length > 0
      wrap_image = main_image
    end
    return wrap_image
  end

  def formatted_price
    if price != nil && price.integer?
      return price.to_s(:delimited)
    else
      return '---'
    end
  end

  def wrapped_title
    if overwritten_title != nil && overwritten_title.length > 0
      return overwritten_title
    end
    return title
  end
end
