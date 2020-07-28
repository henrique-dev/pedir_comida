class Product::ProductsController < AdminController
  before_action :set_product_product, only: [:show, :edit, :update, :destroy]
  before_action :set_product_categories, only: [:new, :edit]
  before_action :set_product_types, only: [:new, :edit]  

  # GET /product/products
  # GET /product/products.json
  def index
    #@product_products = Product::Product.all
    @product_products = Product::Product.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /product/products/1
  # GET /product/products/1.json
  def show
  end

  # GET /product/products/new
  def new
    @product_product = Product::Product.new
  end

  # GET /product/products/1/edit
  def edit
  end

  # POST /product/products
  # POST /product/products.json
  def create
    @product_product = Product::Product.new(product_product_params)

    respond_to do |format|
      if @product_product.save
        format.html { redirect_to @product_product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product_product }
      else
        format.html { render :new }
        format.json { render json: @product_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product/products/1
  # PATCH/PUT /product/products/1.json
  def update
    respond_to do |format|
      if @product_product.update(product_product_params)
        format.html { redirect_to @product_product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_product }
      else
        format.html { render :edit }
        format.json { render json: @product_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product/products/1
  # DELETE /product/products/1.json
  def destroy
    @product_product.destroy
    respond_to do |format|
      format.html { redirect_to product_products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_product
      @product_product = Product::Product.find(params[:id])
    end

    def set_product_categories
      @product_categories = Product::Category.all.pluck(:description, :id)
    end
  
    def set_product_types
      @product_types = Product::Type.all.pluck(:description, :id)
    end

    # Only allow a list of trusted parameters through.
    def product_product_params
      params.require(:product_product).permit(:description, :about, :price, :product_category_id, :product_type_id, :photos => [])
    end
end
