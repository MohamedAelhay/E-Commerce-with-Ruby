class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  belongs_to :store

  has_one_attached :image

  def self.search(params)
    products = Product.where("title LIKE? or description LIKE?", "%#{params[:search]}%",
               "%#{params[:search]}%") if params[:search].present?
    
    products
  end

  def self.filter(params)
    products = Product.where(category: params[:category]) if params[:category].present?
    products = Product.where(brand: params[:brand])       if params[:brand].present?
    products = Product.where(store: params[:seller])      if params[:seller].present?
    products = Product.where(["price <= ?", params[:price].keys.first.to_s]) if params[:price].present?
    products
  end
end
