#json.array! @product_products, partial: "product_products/product_product", as: :product_product
json.cart @cart
json.products(@products) do |product|
    json.id product.id
    json.name product.name
    json.description product.description
    json.price product.price
    json.category product.product_category
    json.type product.product_type
    json.complements product.product_complements.count
    json.ingredients product.product_ingredients.count
    json.variations product.product_variations.count    
    
    if photo = product.photos.sample
        json.photo rails_blob_path(photo, disposition: "attachment", only_path: true)
    else
        json.photo nil
    end    
    #json.photos(product.photos.sample) do |photo|
    #    json.id photo.id
    #    json.url rails_blob_path(photo, disposition: "attachment", only_path: true)
    #end
end