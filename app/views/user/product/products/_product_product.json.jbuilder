json.extract! product_product, :id, :name, :description, :price, :product_category_id, :product_type_id, :created_at, :updated_at
json.url product_product_url(product_product, format: :json)
