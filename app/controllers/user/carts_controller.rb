class User::CartsController < UserController  
  before_action :set_cart, only: [:show, :add, :update_item, :remove, :checkout]
  before_action :set_only_cart, only: [:repurchase]

  def add    
    success = @cart.add(cart_params)
    if (success[:success])
      @cart.save
    end
    render json: success
  end

  def update_item
    success = @cart.update(cart_params)
    if (success[:success])
      @cart.save
    end
    render json: success
  end

  def remove    
    status = @cart.remove(cart_params[:product_id], cart_params[:sub_id])
    if (status == "success")
      @cart.save
    end
    render json: {:status => status}
  end

  def repurchase
    success = @cart.repurchase(order_params[:id])
    if (success[:success])
      @cart.save
    end
    render json: success
  end

  def checkout
    status = @cart.checkout(checkout_params)
    ActionCable.server.broadcast "admin_1",
    { 
      category: "checkout",
      message: @cart.order_checkout.to_json(methods: [:cart]),
    }
    render json: {:status => status}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_only_cart
    @cart = Cart.find_by(user_profile_id: current_user.user_profile_id)
  end

  def set_cart
    if current_user
      @cart = Cart.find_by(user_profile_id: current_user.user_profile_id)
      if params[:only_total]
        @only_total = true
      else
        @only_total = false
        @cart.load_products
        @addresses = current_user.user_profile.addresses
        @payments = current_user.user_profile.payment.payment_physicals
      end
    else
      @cart = Cart.new
    end
  end

  # Only allow a list of trusted parameters through.
  def cart_params
    params.require(:cart).permit(:product_id, :sub_id, :quantity, :complements => [], :variations => [], :ingredients => [])
  end

  def checkout_params
    params.require(:checkout).permit(:address_id, :payment_type, :payment_id)
  end

  def order_params
    params.require(:order).permit(:id)
  end
end
