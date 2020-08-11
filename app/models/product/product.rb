class Product::Product < ApplicationRecord

  attr_accessor :sub_id
  attr_accessor :quantity
  attr_accessor :ingredients
  attr_accessor :complements
  attr_accessor :variations

  has_many :product_complements, :class_name => "Product::Complement", foreign_key: "product_product_id"
  has_many :product_ingredients, :class_name => "Product::Ingredient", foreign_key: "product_product_id"
  has_many :product_variations, :class_name => "Product::Variation", foreign_key: "product_product_id"
  belongs_to :product_category, :class_name => "Product::Category", foreign_key: "product_category_id"
  belongs_to :product_type, :class_name => "Product::Type", foreign_key: "product_type_id"
  has_many_attached :photos
end