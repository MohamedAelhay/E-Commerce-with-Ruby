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

  post 'orders/:id' , to: 'orders#quantity_operations'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
