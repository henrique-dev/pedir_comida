class User::OrdersController < UserController  
  before_action :set_orders, only: [:index]

  def index
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orders
      if current_user
        @cart = Cart.find_by(user_profile_id: current_user.user_profile_id)
        if @cart.locked
          @current_order = @cart.order_checkout
          @old_orders = Order.where(user_profile_id: current_user.user_profile_id)
        else
          @current_order = nil
          @old_orders = Order.where(user_profile_id: current_user.user_profile_id)
        end
      else
        @cart = Cart.new
      end
    end
end
