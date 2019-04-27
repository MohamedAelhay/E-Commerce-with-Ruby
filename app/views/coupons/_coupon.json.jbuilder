json.extract! coupon, :id, :code, :expiration_date, :usage_number, :discount_type, :discount_amount, :created_at, :updated_at
json.url coupon_url(coupon, format: :json)
