class User::RegisterController < ApplicationController
  
  def check_telephone
    render json: {:status => User.check_telephone(register_params[:telephone])}
  end

  def check_token
    user = User.find_by(telephone: register_params[:uid])

    if user && user.valid_token?(register_params[:access_token], register_params[:client])
      render json: {:success => true}
    else
      render json: {:success => false}
    end    
  end

  def confirm_token
    render json: User.confirm_token(register_params)
  end

  private    

  # Only allow a list of trusted parameters through.
  def register_params
    params.require(:register).permit(:id, :uid, :access_token, :client, :telephone, :confirmation_token)
  end
end
