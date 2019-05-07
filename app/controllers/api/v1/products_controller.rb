class Api::V1::ProductsController < ApplicationController
  caches_page :show
  before_action :set_product, only: [:show]
  respond_to :json

  # GET /products
   def index
    @product = Product.all
    render json: @product ,include: ['brand','category','store']
   end
  # GET /products/1
  def show
    render json: @product ,include: ['brand','category','store']
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end
end
