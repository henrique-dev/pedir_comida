Rails.application.routes.draw do
  
  namespace :product do
    resources :products
  end
  namespace :product do
    resources :types
  end
  namespace :product do
    resources :categories
  end
  namespace :home do
    namespace :product do
        end
  end
  namespace :home do
    namespace :product do
        end
  end
  namespace :home do
    namespace :product do
        end
  end
  namespace :home do
    get 'admin/index'
  end
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'inicio', to: 'home/admin#index'
  root to: 'home/admin#index'
end
