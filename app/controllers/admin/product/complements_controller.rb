class Admin::Product::ComplementsController < ApplicationController
  before_action :set_product_complement, only: [:show, :edit, :update, :destroy]

  # GET /product/complements
  # GET /product/complements.json
  def index
    @product_complements = Product::Complement.all
  end

  # GET /product/complements/1
  # GET /product/complements/1.json
  def show
  end

  # GET /product/complements/new
  def new
    @product_complement = Product::Complement.new
  end

  # GET /product/complements/1/edit
  def edit
  end

  # POST /product/complements
  # POST /product/complements.json
  def create
    @product_complement = Product::Complement.new(product_complement_params)

    respond_to do |format|
      if @product_complement.save
        format.html { redirect_to @product_complement, notice: 'Complement was successfully created.' }
        format.json { render :show, status: :created, location: @product_complement }
      else
        format.html { render :new }
        format.json { render json: @product_complement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product/complements/1
  # PATCH/PUT /product/complements/1.json
  def update
    respond_to do |format|
      if @product_complement.update(product_complement_params)
        format.html { redirect_to @product_complement, notice: 'Complement was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_complement }
      else
        format.html { render :edit }
        format.json { render json: @product_complement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product/complements/1
  # DELETE /product/complements/1.json
  def destroy
    @product_complement.destroy
    respond_to do |format|
      format.html { redirect_to product_complements_url, notice: 'Complement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_complement
      @product_complement = Product::Complement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_complement_params
      params.require(:product_complement).permit(:name, :description, :price)
    end
end
