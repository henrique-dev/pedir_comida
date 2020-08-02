class CreateProductProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :product_products do |t|
      t.string :name
      t.string :description
      t.decimal :price, precision: 4, scale: 2
      t.references :product_category, foreign_key: true
      t.references :product_type, foreign_key: true

      t.timestamps
    end
  end
end
