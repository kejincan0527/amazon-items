class Item < ApplicationRecord
  belongs_to :brand

  def wrapped_image
    wrap_image = "https://placehold.it/170x170"
    if main_image != nil && main_image.length > 0
      wrap_image = main_image
    end
    return wrap_image
  end
end
