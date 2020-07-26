class Product::Product < ApplicationRecord
  belongs_to :product_category, :class_name => "Product::Category"
  belongs_to :product_type, :class_name => "Product::Type"
end
