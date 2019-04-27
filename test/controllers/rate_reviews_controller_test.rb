require 'test_helper'

class RateReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rate_review = rate_reviews(:one)
  end

  test "should get index" do
    get rate_reviews_url
    assert_response :success
  end

  test "should get new" do
    get new_rate_review_url
    assert_response :success
  end

  test "should create rate_review" do
    assert_difference('RateReview.count') do
      post rate_reviews_url, params: { rate_review: { product_id: @rate_review.product_id, rate: @rate_review.rate, review: @rate_review.review, user_id: @rate_review.user_id } }
    end

    assert_redirected_to rate_review_url(RateReview.last)
  end

  test "should show rate_review" do
    get rate_review_url(@rate_review)
    assert_response :success
  end

  test "should get edit" do
    get edit_rate_review_url(@rate_review)
    assert_response :success
  end

  test "should update rate_review" do
    patch rate_review_url(@rate_review), params: { rate_review: { product_id: @rate_review.product_id, rate: @rate_review.rate, review: @rate_review.review, user_id: @rate_review.user_id } }
    assert_redirected_to rate_review_url(@rate_review)
  end

  test "should destroy rate_review" do
    assert_difference('RateReview.count', -1) do
      delete rate_review_url(@rate_review)
    end

    assert_redirected_to rate_reviews_url
  end
end
