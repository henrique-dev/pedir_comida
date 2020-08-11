class User::Product::ProductsController < UserController
  before_action :set_product_product, only: [:show, :edit, :update, :destroy]
  before_action :set_cart

  # GET /product/products
  # GET /product/products.json
  def index
    if params[:category]
      @products = Product::Product.where(product_category_id: params[:category])
    else
      @products = Product::Product.all      
    end    
    #@products = Product::Product.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /product/products/1
  # GET /product/products/1.json
  def show
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_product
      @product = Product::Product.find(params[:id])
      if params[:sub_id] && params[:sub_id].to_i > 0
        set_cart
        @product_from_cart = @cart.items.select {|i| i["product_id"] == params[:id].to_i && i["sub_id"] == params[:sub_id].to_i}
      end
    end

    # Only allow a list of trusted parameters through.
    def product_product_params
      params.require(:product_product).permit(:name, :description, :price, :product_category_id, :product_type_id, :photos => [])
    end
end
