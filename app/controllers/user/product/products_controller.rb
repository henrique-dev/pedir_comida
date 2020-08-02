class User::Product::ProductsController < UserController
  before_action :set_product_product, only: [:show, :edit, :update, :destroy]

  # GET /product/products
  # GET /product/products.json
  def index
    #@product_products = Product::Product.all
    @products = Product::Product.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /product/products/1
  # GET /product/products/1.json
  def show
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_product
      @product_product = Product::Product.find(params[:id])
    end

    def set_product_categories
      @product_categories = Product::Category.all.pluck(:name, :id)
    end
  
    def set_product_types
      @product_types = Product::Type.all.pluck(:name, :id)
    end

    # Only allow a list of trusted parameters through.
    def product_product_params
      params.require(:product_product).permit(:name, :description, :price, :product_category_id, :product_type_id, :photos => [])
    end
end
