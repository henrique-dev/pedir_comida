class UserController < ActionController::Base
    include DeviseTokenAuth::Concerns::SetUserByToken
    #skip_before_action :verify_authenticity_token
    skip_before_action :verify_authenticity_token, only: [:create]
    #before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?


    def configure_permitted_parameters
        added_attrs = [:telephone, :email, :password, :password_confirmation, :remember_me]
        devise_parameter_sanitizer.permit :sign_in, keys: [:telephone, :email, :password, :session]
        #devise_parameter_sanitizer.permit :auth, keys: 
        #devise_parameter_sanitizer.permit :session, keys: [:telephone, :email, :password]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs + [:telephone, :email, :password, :session, :name, :genre, :birth_date, :height, :bloodtype, :cpf, :weight]
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
end