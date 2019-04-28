Rails.application.routes.draw do
  resources :rate_reviews
  resources :order_products
  resources :user_coupons
  resources :orders
  resources :products
  resources :coupons
  resources :stores
  resources :categories
  resources :brands
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
