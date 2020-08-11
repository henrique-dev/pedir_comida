#json.array! @product_categories, partial: "product_categories/product_category", as: :product_category
json.guest @cart.id == nil
json.cart @cart
json.categories(@categories) do |category|
    json.id category.id
    json.name category.name

    sample = category.product_products.sample

    if sample && photo = sample.photos.first
        json.photo rails_blob_path(photo, disposition: "attachment", only_path: true)
    else
        json.photo nil
    end
end