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

end
