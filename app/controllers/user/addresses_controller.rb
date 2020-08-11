class User::AddressesController < UserController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @addresses = Address.where(user_profile_id: current_user.user_profile_id)
  end

  def show
  end

  def new
  end
  
  def edit    
  end

  def create    
    @address = Address.new(address_params.merge({user_profile_id: current_user.user_profile_id}))
    @address.default = true if Address.where(user_profile_id: current_user.user_profile_id).count == 0
    if @address.save
      render :show, status: :created
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @address.update(address_params)
      render :show, status: :ok
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user_profile.destroy
    respond_to do |format|
      format.html { redirect_to user_profiles_url, notice: 'User profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find_by(id: params[:id], user_profile_id: current_user.user_profile_id)
    end

    def address_params
      params.require(:address).permit(:description, :street, :number, :neighborhood, :city, :state, :country, :zipcode, :latitude, :longitude, :default)
    end

end
