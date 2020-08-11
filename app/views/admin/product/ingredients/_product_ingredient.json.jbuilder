json.extract! product_ingredient, :id, :name, :description, :price, :created_at, :updated_at
json.url product_ingredient_url(product_ingredient, format: :json)
