class Admin::UserProfilesController < AdminController
  before_action :set_user_profile, only: [:show, :edit, :update, :destroy, :send_confirmation_token]
  before_action :authenticate_admin!

  def send_confirmation_token
    @user.send_confirmation_token
    redirect_to user_profiles_url
  end

  # GET /user_profiles
  # GET /user_profiles.json
  def index
    @user_profiles = UserProfile.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /user_profiles/1
  # GET /user_profiles/1.json
  def show
  end

  # GET /user_profiles/new
  def new
    @user_profile = UserProfile.new    
    @address = Address.new
    @user = User.new
  end

  # GET /user_profiles/1/edit
  def edit    
  end

  # POST /user_profiles
  # POST /user_profiles.json
  def create
    @user_profile = UserProfile.new(user_profile_params)
    @user = User.new(user_profile_params.merge({:provider => "email" ,:email => user_profile_params[:uid]}))
    @address = Address.new(address_params)
    if @user_profile.validate
      if @user.validate
        if @address.validate
          if @user.save && @address.save
            @user_profile = @user.user_profile
            @user_profile.save if @user_profile.address = @address            
            redirect_to @user_profile, notice: 'Paciente criado com sucesso.'
          end
        end
      else
        render :new
      end
    else
      render :new
    end
  end

  # PATCH/PUT /user_profiles/1
  # PATCH/PUT /user_profiles/1.json
  def update
    respond_to do |format|
      if @user_profile.update(user_profile_params) && @address.update(address_params)
        format.html { redirect_to @user_profile, notice: 'User profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_profile }
      else
        format.html { render :edit }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_profiles/1
  # DELETE /user_profiles/1.json
  def destroy
    @user_profile.destroy
    respond_to do |format|
      format.html { redirect_to user_profiles_url, notice: 'User profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_profile
      @user_profile = UserProfile.find(params[:id])
      @user = @user_profile.user
    end

    # Only allow a list of trusted parameters through.
    def user_profile_params
      hash = params.require(:user_profile).permit(:cpf, :password, :password_confirmation, :uid, :email, 
        :name, :genre, :birth_date, :height, :bloodtype, :telephone, :weight, :created_by_admin)
      if hash[:cpf]
        hash[:cpf] = hash[:cpf].gsub(".", "")
        hash[:cpf] = hash[:cpf].gsub("-", "")
      end
      hash
    end

    def address_params
      params.require(:address).permit(:zipcode, :street, :street, :neighborhood, :city, :state, :country)
    end

end
