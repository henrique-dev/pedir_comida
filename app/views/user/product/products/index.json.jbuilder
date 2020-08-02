#json.array! @product_products, partial: "product_products/product_product", as: :product_product
json.array!(@products) do |product|
    json.id product.id
    json.name product.name
    json.description product.description
    json.price product.price
    #json.category product.category
    #json.type product.type
end