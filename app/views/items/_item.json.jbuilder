json.extract! item, :id, :asin, :title, :description, :price, :amazon_url, :brand, :group, :main_image, :stocks, :created_at, :updated_at
json.url item_url(item, format: :json)
