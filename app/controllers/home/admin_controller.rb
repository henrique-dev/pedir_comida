class Home::AdminController < AdminController
  def index
    @orders = Checkout.all
  end
end
