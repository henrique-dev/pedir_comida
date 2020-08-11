class Product::Type < ApplicationRecord
    has_many :product_products, :class_name => "Product::Product", foreign_key: "product_type_id"
end
