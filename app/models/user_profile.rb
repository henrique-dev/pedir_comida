class UserProfile < ApplicationRecord

    attr_accessor :telephone
    attr_accessor :uid
    attr_accessor :password
    attr_accessor :password_confirmation
    attr_accessor :created_by_admin

    has_many :addresses, dependent: :destroy
    has_one :user, dependent: :destroy
    has_one :cart, dependent: :destroy    
    has_one :payment, dependent: :destroy
    has_one :order_checkout, dependent: :destroy, class_name: "Checkout"
    has_one :order, dependent: :destroy, class_name: "Order"

    validates :name, presence: true

end
