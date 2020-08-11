class CreateProductIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :product_ingredients do |t|
      t.string :name
      t.string :description
      t.decimal :price, precision: 4, scale: 2
      t.boolean :checked
      
      t.references :product_product, foreign_key: true

      t.timestamps
    end
  end
end
