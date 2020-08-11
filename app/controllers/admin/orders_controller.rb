class Admin::OrdersController < AdminController
  before_action :set_order, only: [:confirm]

  def confirm
    user = @checkout.user_profile.user

    if @checkout.set_status "done"
      ActionCable.server.broadcast "user_#{user.id}",
      { 
        category: "order_status_change",
        message: "done",
      }
    end
    
    redirect_to home_admin_index_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @checkout = Checkout.find(params["id"])
    end
end
