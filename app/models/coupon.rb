class Coupon < ApplicationRecord
    DISCOUNT_OPTIONS = %w(persentage fixed)
    validates :code, presence: true,uniqueness: true
    validates :expiration_date, allow_nil: true,uniqueness: true
    validates :usage_number, allow_nil: true, numericality: { only_integer: true ,greater_than:0}
    validate  :expiration_date_xor_usage_number
    validates :discount_type,presence: true, :inclusion => {:in =>  DISCOUNT_OPTIONS}
    validates :discount_amount, numericality: { only_integer: true ,greater_than:0}
    def self.isValid (code)
        if(Coupon.exists?(code: code))
            coupon=Coupon.find_by(code: code)
            if ((!coupon.expiration_date.nil?)&&(!coupon.usage_number.nil?))
                 return (coupon.expiration_date>Time.now )&&(coupon.usage_number>0)
            elsif (!coupon.expiration_date.nil?)
                 return coupon.expiration_date>Time.now  
            elsif ((!coupon.usage_number.nil?))
                 return coupon.usage_number>0 
            end  
            return false            
        else
            return false
        end
    end
    def self.after_discount(current_amount,code)
      coupon=Coupon.find_by(code: code)
      if(coupon.discount_type=="persentage")
        new_amount=current_amount.to_f-(current_amount.to_f*(coupon.discount_amount.to_f/100))
      elsif(coupon.discount_type=="fixed")
        new_amount=current_amount.to_f-coupon.discount_amount.to_f
        if (new_amount<0)
          new_amount=0
        end
      end
        return new_amount    
    end
  private
    def  expiration_date_xor_usage_number
      if expiration_date.blank? and usage_number.blank?
        errors.add(:base, "Specify a expiration date or a usage number or both")
      end
    end
end
