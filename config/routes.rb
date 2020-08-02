Rails.application.routes.draw do
  devise_for :admins
  mount_devise_token_auth_for 'User', at: 'users/auth'  

  scope module: 'admin' do
    resources :user_profiles
    namespace :product do
      resources :products
      resources :types
      resources :categories
    end
        
  end

  namespace :home do
    get 'admin/index'
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'inicio', to: 'home/admin#index'
  root to: 'home/admin#index'
end
