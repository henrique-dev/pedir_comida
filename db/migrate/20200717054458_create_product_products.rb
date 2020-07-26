class CreateProductProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :product_products do |t|
      t.string :description
      t.string :about
      t.decimal :price
      t.references :product_category, foreign_key: true
      t.references :product_type, foreign_key: true

      t.timestamps
    end
  end
end
