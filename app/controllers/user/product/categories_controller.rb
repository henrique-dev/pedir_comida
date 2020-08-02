class Product::CategoriesController < UserController
  before_action :set_product_category, only: [:show, :edit, :update, :destroy]  

  # GET /product/categories
  # GET /product/categories.json
  def index
    @product_categories = Product::Category.all
  end

  # GET /product/categories/1
  # GET /product/categories/1.json
  def show
  end

  # GET /product/categories/new
  def new
    @product_category = Product::Category.new
  end

  # GET /product/categories/1/edit
  def edit
  end

  # POST /product/categories
  # POST /product/categories.json
  def create
    @product_category = Product::Category.new(product_category_params)

    respond_to do |format|
      if @product_category.save
        format.html { redirect_to @product_category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @product_category }
      else
        format.html { render :new }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product/categories/1
  # PATCH/PUT /product/categories/1.json
  def update
    respond_to do |format|
      if @product_category.update(product_category_params)
        format.html { redirect_to @product_category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_category }
      else
        format.html { render :edit }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product/categories/1
  # DELETE /product/categories/1.json
  def destroy
    @product_category.destroy
    respond_to do |format|
      format.html { redirect_to product_categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
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
