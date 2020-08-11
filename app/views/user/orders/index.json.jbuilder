#json.array! @carts, partial: "user/carts/cart", as: :cart
if @current_order
    json.current_order do |co|
        co.checkout @current_order
        co.address @current_order.address
        co.cart @cart    
    end
else

end
json.old_orders(@old_orders) do |old_order|
    json.id old_order.id
    json.status old_order.status
    json.payment_method old_order.payment_method
    json.items old_order.items
    json.address old_order.address
end
#json.old_orders @old_orders