class Product::VariationsController < UserController
  before_action :set_product_variation, only: [:show, :edit, :update, :destroy]

  # GET /product/variations
  # GET /product/variations.json
  def index
    @product_variations = Product::Variation.all
  end

  # GET /product/variations/1
  # GET /product/variations/1.json
  def show
  end

  # GET /product/variations/new
  def new
    @product_variation = Product::Variation.new
  end

  # GET /product/variations/1/edit
  def edit
  end

  # POST /product/variations
  # POST /product/variations.json
  def create
    @product_variation = Product::Variation.new(product_variation_params)

    respond_to do |format|
      if @product_variation.save
        format.html { redirect_to @product_variation, notice: 'Variation was successfully created.' }
        format.json { render :show, status: :created, location: @product_variation }
      else
        format.html { render :new }
        format.json { render json: @product_variation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product/variations/1
  # PATCH/PUT /product/variations/1.json
  def update
    respond_to do |format|
      if @product_variation.update(product_variation_params)
        format.html { redirect_to @product_variation, notice: 'Variation was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_variation }
      else
        format.html { render :edit }
        format.json { render json: @product_variation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product/variations/1
  # DELETE /product/variations/1.json
  def destroy
    @product_variation.destroy
    respond_to do |format|
      format.html { redirect_to product_variations_url, notice: 'Variation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_variation
      @product_variation = Product::Variation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_variation_params
      params.require(:product_variation).permit(:name, :description, :price)
    end
end
