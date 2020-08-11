class CreateCheckouts < ActiveRecord::Migration[5.2]
  def change
    create_table :checkouts do |t|
      t.string :status, default: "waiting_confirmation"
      t.json :payment_method
      
      t.references :cart, foreign_key: true
      t.references :user_profile, foreign_key: true
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
