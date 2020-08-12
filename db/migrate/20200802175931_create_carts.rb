class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.decimal :total, precision: 6, scale: 2      
      t.json :items
      t.boolean :locked, default: false
      t.integer :sub_id_increment, default: 1
      t.integer :current_address_id
      
      t.references :user_profile, foreign_key: true

      t.timestamps
    end
  end
end
