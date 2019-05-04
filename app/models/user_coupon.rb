class UserCoupon < ApplicationRecord
  belongs_to :user
  belongs_to :coupon
  def self.taken_before(user_id,code)
    coupon=Coupon.find_by(code: code)
    userCoupon=UserCoupon.find_by("user_id = ? OR coupon_id = ?", user_id,coupon.id)
    if (userCoupon.nil?)
      return false
    end
      return true 
  end
end
