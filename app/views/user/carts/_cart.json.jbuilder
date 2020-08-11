json.extract! cart, :id, :items, :created_at, :updated_at
json.url user_carts_url(cart, format: :json)
