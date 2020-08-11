#json.partial! "product_products/product_product", product_product: @product_product
json.id @product.id
json.name @product.name
json.description @product.description
json.price @product.price
json.category @product.product_category
json.type @product.product_type
json.min_complements @product.min_complements
json.max_complements @product.max_complements
json.max_ingredients @product.max_ingredients
json.min_variations @product.min_variations
json.max_variations @product.max_variations
json.complements @product.product_complements
json.ingredients @product.product_ingredients
json.variations @product.product_variations
if photo = @product.photos.sample
    json.photo rails_blob_path(photo, disposition: "attachment", only_path: true)
else
    json.photo nil
end
if @product_from_cart
    json.product_from_cart @product_from_cart[0]
end