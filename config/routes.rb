Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
  
  devise_for :admins
  mount_devise_token_auth_for 'User', at: 'users/auth', controllers: {
    sessions: "overrides/sessions",
    registrations: "overrides/registrations"
  }

  scope module: 'admin' do

    resources :user_profiles do
      collection do
        get :send_confirmation_token
      end
    end

    resources :orders do
      collection do
        #post :confirm
        get :confirm
      end
    end

    namespace :product do
      resources :products
      resources :types
      resources :categories
      resources :complements
      resources :variations
      resources :ingredients
    end
  end

  namespace :user do

    resources :user_profiles
    resources :orders
    resources :addresses

    resources :register do
      collection do        
        post :check_telephone, :check_token, :confirm_token
      end  
    end

    resources :carts do
      collection do        
        post :add, :update_item, :remove, :checkout
      end  
    end

    scope module: 'product' do
      resources :products
      resources :types
      resources :categories
      resources :complements
      resources :variations
      resources :ingredients      
    end
  end

  namespace :home do
    get 'admin/index'
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'inicio', to: 'home/admin#index'
  root to: 'home/admin#index'
end
