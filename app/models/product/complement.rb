class Product::Complement < ApplicationRecord
    belongs_to :product_product, :class_name => "Product::Product", foreign_key: "product_product_id"
end
