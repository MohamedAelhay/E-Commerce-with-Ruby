class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  belongs_to :store

  has_many :rate_reviews

  has_many :order_products
  has_many :orders, through: :order_products

  has_one_attached :image

  def self.search(params)
    products = Product.where("title LIKE? or description LIKE?", "%#{params[:search]}%",
               "%#{params[:search]}%") if params[:search].present?
    
    products
  end

end
