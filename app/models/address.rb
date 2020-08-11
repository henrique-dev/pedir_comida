class Address < ApplicationRecord
    has_many :order_checkouts, dependent: :destroy, class_name: "Checkout"
    has_many :orders, dependent: :destroy, class_name: "Order"
    belongs_to :user_profile, optional: true

    validates :description, presence: true, length: { maximum: 50 }
    validates :street, presence: true, length: { maximum: 200 }
    validates :number, presence: true, length: { maximum: 15 }
    validates :neighborhood, presence: true, length: { maximum: 200 }
    validates :city, presence: true, length: { maximum: 200 }
    validates :zipcode, presence: true, length: { maximum: 15 }
end
