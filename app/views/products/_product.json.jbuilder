json.extract! product, :id, :brand_id, :category_id, :store_id, :title, :description, :image, :price, :quantity, :created_at, :updated_at
json.url product_url(product, format: :json)
