class Payment < ApplicationRecord
    belongs_to :user_profile, optional: true
    has_many :payment_physicals, dependent: :destroy, class_name: "Payment::Physical"
end