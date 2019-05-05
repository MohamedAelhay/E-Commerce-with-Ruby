class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # attr_accessor :username
  has_many :rate_reviews
  has_many :orders
  has_one :store
  
  # scope :sellers, => { 
  #   where(:role_type => "seller") 
  # }
  RULE_OPTIONS = %w(seller buyer)
  validates :role_type, :inclusion => {:in => RULE_OPTIONS}
  has_one_attached :image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def self.get_sellers
    User.where("role_type = ?", "seller")
    
  end       
end
