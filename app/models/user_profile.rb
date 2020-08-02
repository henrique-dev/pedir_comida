class UserProfile < ApplicationRecord

    attr_accessor :telephone
    attr_accessor :uid
    attr_accessor :password
    attr_accessor :password_confirmation
    attr_accessor :created_by_admin

    has_one :user, dependent: :destroy

    belongs_to :address, optional: true

    validates :name, presence: true
    validates :genre, presence: true

end
