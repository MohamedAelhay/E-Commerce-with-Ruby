class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  belongs_to :store

  has_many :rate_reviews

  has_many :order_products
  has_many :orders, through: :order_products

  has_one_attached :image

  #Validation
  validates :brand,         presence: true
  validates :category,      presence: true
  validates :store,         presence: true
  validates :title,         presence: true, length: { minimum: 3 }
  validates :description,   presence: true, length: { minimum: 5 }
  validates :price,         presence: true
  validates :quantity,      presence: true
  
  def self.search(params)
    products = Product.where("title LIKE? or description LIKE?", "%#{params[:search]}%",
               "%#{params[:search]}%") if params[:search].present?
    
    products
  end

  def self.filter(params)
    products = Product.where(category: params[:category])                     if params[:category].present?
    products = Product.where(brand: params[:brand])                           if params[:brand].present?
    products = Product.where(store: params[:seller])                          if params[:seller].present?
    products = Product.where(["price <= ?", params[:price].keys.first.to_s])  if params[:price].present?
    products
  end
end
