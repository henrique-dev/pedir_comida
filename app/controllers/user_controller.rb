class UserController < ApplicationController
    before_action :authenticate_user!

    def set_cart
        if current_user
            @cart = Cart.find_by(user_profile_id: current_user.user_profile_id)
        else
            @cart = Cart.new            
        end
    end

end