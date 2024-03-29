class Checkout < ApplicationRecord
    belongs_to :cart, optional: true
    belongs_to :address, optional: true
    belongs_to :user_profile, optional: true

    def set_status status
        if is_status?(status)
            case status
            when "done"
                order = Order.new
                order.payment_method = self.payment_method
                order.user_profile_id = self.user_profile_id
                order.address_id = self.address_id
                order.items = self.cart
                if order.save
                    cart = self.cart
                    cart.locked = false
                    cart.items = nil
                    cart.current_address_id = nil
                    cart.save
                    self.destroy
                    return true
                end
            else
                self.status = status
                self.save
                return true
            end
        end
        return false
    end

    def is_status? status
        [
            "waiting_confirmation", 
            "not_confirmed",
            "confirmed",
            "in_production",
            "waiting_deliveryman",
            "sent",
            "done",
        ].include?(status)
    end
end