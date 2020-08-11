class Product::Category < ApplicationRecord
    has_many :product_products, :class_name => "Product::Product", foreign_key: "product_category_id"
end
