Rails.application.routes.draw do
  resources :rate_reviews
  resources :order_products
  resources :user_coupons
  resources :orders
  resources :products do
    collection do
      get :search
    end
  end

  resources :coupons
  resources :stores
  resources :categories
  resources :brands
  devise_for :users
  root 'products#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
