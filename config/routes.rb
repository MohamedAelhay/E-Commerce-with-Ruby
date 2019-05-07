Rails.application.routes.draw do
  resources :products do
    collection do
      get :search
    end
    collection do
      get :filter
    end
  end
  resources :orders do
    delete :remove_product, on: :member
  end
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :rate_reviews
  resources :order_products
  resources :orders
  resources :products
  namespace :admin do
    resources :coupons
    resources :categories
    resources :brands
    resources :user_coupons
  end
  resources :stores
  devise_for :users
  root 'products#index'
  post '/products/:id/addToCart' ,to: 'orders#add_to_cart'
  post '/products/:id/removeFromCart' ,to: 'orders#removeFromCart'
  namespace :api do
    scope module: :v1 , path: 'v1'do
      # We are going to list our resources here
      resources :products
    end
  end
  post '/orders/:id' , to: 'orders#quantity_operations'
  # post '/orders/:id' , to: 'orders#validate_coupon'
  post '/orders/:id/apply_coupon', to:'orders#apply_coupon'

  # post 'products', to: 'products#add_to_cart'
  post "/orders/:id/check_out" ,to: 'orders#check_out'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
