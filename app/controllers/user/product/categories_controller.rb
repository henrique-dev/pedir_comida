class User::Product::CategoriesController < UserController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_cart

  def index
    @categories = Product::Category.all
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_category
      @product_category = Product::Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_category_params
      params.require(:product_category).permit(:name)
    end
end
