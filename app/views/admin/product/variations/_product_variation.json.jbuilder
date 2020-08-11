json.extract! product_variation, :id, :name, :description, :price, :created_at, :updated_at
json.url product_variation_url(product_variation, format: :json)
