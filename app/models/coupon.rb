class Coupon < ApplicationRecord
    validates :code, presence: true,uniqueness: true
    validates :expiration_date, allow_nil: true,uniqueness: true
    validates :usage_number, allow_nil: true, numericality: { only_integer: true ,greater_than:0}
    #validates :code, presence: true,uniqueness: true
    validate :charge_xor_payment
    def self.isValid (code)
        if(Coupon.exists?(code: code))
            coupon=Coupon.where(code: code)
            if (coupon.expiration_date.nil?&&coupon.expiration_date>Time.now)
            end
            
        else
            return "Coupon does not exist ."
        end

    end

  private
    def charge_xor_payment
      if expiration_date.blank? and usage_number.blank?
        errors.add(:base, "Specify a expiration date or a usage number or both")
      end
    end
end
