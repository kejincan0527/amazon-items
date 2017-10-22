json.extract! item, :id, :asin, :title, :description, :price, :amazon_url, :brand_id, :group, :main_image, :stocks, :active, :created_at, :updated_at
json.url item_url(item, format: :json)
