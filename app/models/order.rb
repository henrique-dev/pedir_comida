class Order < ApplicationRecord
    belongs_to :address, optional: true
    belongs_to :user_profile, optional: true
end