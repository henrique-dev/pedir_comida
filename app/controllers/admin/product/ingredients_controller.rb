class Admin::Product::IngredientsController < ApplicationController
  before_action :set_product_ingredient, only: [:show, :edit, :update, :destroy]

  # GET /product/ingredients
  # GET /product/ingredients.json
  def index
    @product_ingredients = Product::Ingredient.all
  end

  # GET /product/ingredients/1
  # GET /product/ingredients/1.json
  def show
  end

  # GET /product/ingredients/new
  def new
    @product_ingredient = Product::Ingredient.new
  end

  # GET /product/ingredients/1/edit
  def edit
  end

  # POST /product/ingredients
  # POST /product/ingredients.json
  def create
    @product_ingredient = Product::Ingredient.new(product_ingredient_params)

    respond_to do |format|
      if @product_ingredient.save
        format.html { redirect_to @product_ingredient, notice: 'Ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @product_ingredient }
      else
        format.html { render :new }
        format.json { render json: @product_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product/ingredients/1
  # PATCH/PUT /product/ingredients/1.json
  def update
    respond_to do |format|
      if @product_ingredient.update(product_ingredient_params)
        format.html { redirect_to @product_ingredient, notice: 'Ingredient was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_ingredient }
      else
        format.html { render :edit }
        format.json { render json: @product_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product/ingredients/1
  # DELETE /product/ingredients/1.json
  def destroy
    @product_ingredient.destroy
    respond_to do |format|
      format.html { redirect_to product_ingredients_url, notice: 'Ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_ingredient
      @product_ingredient = Product::Ingredient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_ingredient_params
      params.require(:product_ingredient).permit(:name, :description, :price)
    end
end
