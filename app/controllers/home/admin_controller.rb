class Home::AdminController < AdminController

  def index
    @orders_waiting_confirmation = Checkout.where(status: "waiting_confirmation")
    @orders = Checkout.where(status: ["confirmed", "in_production", "waiting_deliveryman", "sent", "done"])
    if !(params[:see_id] && @order = Checkout.find(params[:see_id]))
      @order = @orders.last
    end
    if @order
      @order.cart.load_products
    end
    @list_status = [
      {:id => "confirmed", :name => "Confirmado"},
      {:id => "in_production", :name => "Em produção"},
      {:id => "waiting_deliveryman", :name => "Esperando entregador"},
      {:id => "sent", :name => "Enviado"},
      {:id => "done", :name => "Entregue"}
    ].pluck(:name, :id)
  end

end
