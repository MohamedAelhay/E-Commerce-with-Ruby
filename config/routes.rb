Rails.application.routes.draw do
  resources :products do
    collection do
      get :search
    end

    collection do
      get :filter
    end
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :rate_reviews
  resources :order_products
  resources :orders
  resources :products
  namespace :admin do
    resources :coupons
    resources :stores
    resources :categories
    resources :brands
    resources :user_coupons
  end
  
  devise_for :users
  root 'products#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
