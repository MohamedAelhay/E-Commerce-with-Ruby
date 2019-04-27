json.extract! rate_review, :id, :product_id, :user_id, :rate, :review, :created_at, :updated_at
json.url rate_review_url(rate_review, format: :json)
