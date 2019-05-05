class Order < ApplicationRecord
  belongs_to :user
  belongs_to :coupon

  has_many :order_products
  has_many :products, through: :order_products


end
