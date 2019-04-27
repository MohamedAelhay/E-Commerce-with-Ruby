require "application_system_test_case"

class RateReviewsTest < ApplicationSystemTestCase
  setup do
    @rate_review = rate_reviews(:one)
  end

  test "visiting the index" do
    visit rate_reviews_url
    assert_selector "h1", text: "Rate Reviews"
  end

  test "creating a Rate review" do
    visit rate_reviews_url
    click_on "New Rate Review"

    fill_in "Product", with: @rate_review.product_id
    fill_in "Rate", with: @rate_review.rate
    fill_in "Review", with: @rate_review.review
    fill_in "User", with: @rate_review.user_id
    click_on "Create Rate review"

    assert_text "Rate review was successfully created"
    click_on "Back"
  end

  test "updating a Rate review" do
    visit rate_reviews_url
    click_on "Edit", match: :first

    fill_in "Product", with: @rate_review.product_id
    fill_in "Rate", with: @rate_review.rate
    fill_in "Review", with: @rate_review.review
    fill_in "User", with: @rate_review.user_id
    click_on "Update Rate review"

    assert_text "Rate review was successfully updated"
    click_on "Back"
  end

  test "destroying a Rate review" do
    visit rate_reviews_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rate review was successfully destroyed"
  end
end
