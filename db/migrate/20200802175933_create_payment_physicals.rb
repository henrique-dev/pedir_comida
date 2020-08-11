class CreatePaymentPhysicals < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_physicals do |t|
      t.string :payment_type, default: ""
      t.string :payment_type2, default: ""
      t.string :payment_type3, default: ""
      t.string :name, default: ""
      t.string :description, default: ""
      t.string :payment_observation, default: ""
      t.string :observation, default: ""
      t.boolean :default, default: false

      t.references :payment, foreign_key: true

      t.timestamps
    end
  end
end
