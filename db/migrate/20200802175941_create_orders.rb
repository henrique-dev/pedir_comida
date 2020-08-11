class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :status, default: "done"
      t.json :payment_method
      t.json :items

      t.references :user_profile, foreign_key: true
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
