#json.partial! "user/carts/cart", cart: @cart
json.guest @cart.id == nil
if @only_total
    json.cart @cart
else
    json.addresses @addresses
    json.sub_total @cart.total
    json.tax 10
    json.taxes @cart.taxes
    json.total @cart.total
    json.items @cart.products.to_json(methods: [:sub_id, :quantity, :complements, :ingredients, :variations])
    json.payments @payments
end