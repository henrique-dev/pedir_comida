class Admin::OrdersController < AdminController
  before_action :set_order, only: [:confirm, :set_status]

  def update
    @checkout = Checkout.find(checkout_params["id"])
    user = @checkout.user_profile.user
    
    if @checkout.set_status checkout_params["status"]
      ActionCable.server.broadcast "user_#{user.id}",
      { 
        category: "order_status_change",
        message: checkout_params["status"],
      }
    end
    
    redirect_to home_admin_index_path
  end

  def confirm
    user = @checkout.user_profile.user

    if @checkout.set_status "confirmed"
      ActionCable.server.broadcast "user_#{user.id}",
      { 
        category: "order_status_change",
        message: "confirmed",
      }
    end
    
    redirect_to home_admin_index_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @checkout = Checkout.find(params["id"])
    end

    def checkout_params
      params.require(:checkout).permit(:id, :status)
    end
end
