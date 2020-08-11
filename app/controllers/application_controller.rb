class ApplicationController < ActionController::Base
    include DeviseTokenAuth::Concerns::SetUserByToken
    protect_from_forgery
    skip_before_action :verify_authenticity_token
    before_action :configure_permitted_parameters, if: :devise_controller?


    def configure_permitted_parameters
        added_attrs = [:telephone, :email, :password, :password_confirmation, :remember_me]
        #devise_parameter_sanitizer.permit(:sign_up, keys: [:uid, :provider])
        devise_parameter_sanitizer.permit :sign_in, keys: [:telephone, :email, :password, :session]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs + [:telephone, :email, :password, :session, :name, :genre, :birth_date, :cpf]
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

end
