json.extract! cart, :id, :items, :created_at, :updated_at
json.url cart_url(cart, format: :json)
