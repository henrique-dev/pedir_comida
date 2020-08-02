class Product::TypesController < AdminController
  before_action :set_product_type, only: [:show, :edit, :update, :destroy]

  # GET /product/types
  # GET /product/types.json
  def index
    @product_types = Product::Type.all
  end

  # GET /product/types/1
  # GET /product/types/1.json
  def show
  end

  # GET /product/types/new
  def new
    @product_type = Product::Type.new
  end

  # GET /product/types/1/edit
  def edit
  end

  # POST /product/types
  # POST /product/types.json
  def create
    @product_type = Product::Type.new(product_type_params)

    respond_to do |format|
      if @product_type.save
        format.html { redirect_to @product_type, notice: 'Type was successfully created.' }
        format.json { render :show, status: :created, location: @product_type }
      else
        format.html { render :new }
        format.json { render json: @product_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product/types/1
  # PATCH/PUT /product/types/1.json
  def update
    respond_to do |format|
      if @product_type.update(product_type_params)
        format.html { redirect_to @product_type, notice: 'Type was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_type }
      else
        format.html { render :edit }
        format.json { render json: @product_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product/types/1
  # DELETE /product/types/1.json
  def destroy
    @product_type.destroy
    respond_to do |format|
      format.html { redirect_to product_types_url, notice: 'Type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_type
      @product_type = Product::Type.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_type_params
      params.require(:product_type).permit(:name)
    end
end
