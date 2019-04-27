json.extract! order, :id, :user_id, :coupon_id, :state, :order_date, :confirmation_date, :deliverable_date, :address, :total_price, :total_price_after_discount, :created_at, :updated_at
json.url order_url(order, format: :json)
