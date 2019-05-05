class RateReviewsController < ApplicationController
  before_action :set_rate_review, only: [:show, :edit, :update, :destroy]

  # GET /rate_reviews
  # GET /rate_reviews.json
  def index
    @rate_reviews = RateReview.all
    @products = Product.all
  end

  # GET /rate_reviews/1
  # GET /rate_reviews/1.json
  def show
  end

  # GET /rate_reviews/new
  def new
    @rate_review = RateReview.new
  end

  # GET /rate_reviews/1/edit
  def edit
  end

  # POST /rate_reviews
  # POST /rate_reviews.json
  def create
    @rate_review = RateReview.new(rate_review_params)

    respond_to do |format|
      if @rate_review.save
        format.html { redirect_to @rate_review, notice: 'Rate review was successfully created.' }
        format.json { render :show, status: :created, location: @rate_review }
      else
        format.html { render :new }
        format.json { render json: @rate_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rate_reviews/1
  # PATCH/PUT /rate_reviews/1.json
  def update
    respond_to do |format|
      if @rate_review.update(rate_review_params)
        format.html { redirect_to @rate_review, notice: 'Rate review was successfully updated.' }
        format.json { render :show, status: :ok, location: @rate_review }
      else
        format.html { render :edit }
        format.json { render json: @rate_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rate_reviews/1
  # DELETE /rate_reviews/1.json
  def destroy
    @rate_review.destroy
    respond_to do |format|
      format.html { redirect_to rate_reviews_url, notice: 'Rate review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate_review
      @rate_review = RateReview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rate_review_params
      params.require(:rate_review).permit(:product_id, :user_id, :rate, :review)
    end
end
