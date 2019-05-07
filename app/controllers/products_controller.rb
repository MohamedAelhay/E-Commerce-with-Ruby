class ProductsController < ApplicationController
  #caches_page :show
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  respond_to :html, :json
  load_and_authorize_resource

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    @categories = Category.all
    @sellers = Store.all
    @brands = Brand.all
    @new_products = Product.last(5)
    @orderproducts = OrderProduct.all
    @orders = Order.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @cart_quantity=0
    if(current_user)
      @lastOrder=current_user.orders
      if(@lastOrder.size != 0)
          @last=@lastOrder.last
        if( @last.state =="cart")
          @cart_product=@last.order_products.find_by(product_id: params[:id])
          @cart_quantity=@cart_product.Product_quantity unless @cart_product.nil?
        end
      end     
    end

  end

  # GET /products/new
  def new
    @product = Product.new
    @categories = Category.all
    @brands = Brand.all
    @stores = Store.where(user_id: current_user.id)
  end

  # GET /products/1/edit
  def edit
    @categories = Category.all
    @brands = Brand.all
    @stores = Store.all
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @store = store_path(current_user.id)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @store, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  #Search product
  def search
    if params[:search].blank? 
      @products = Product.all
    else
      @products = Product.search(params)
      @categories = Category.all
      @sellers = Store.all
      @brands = Brand.all
    end
  end

  #Filter product
  def filter
    if (params[:category].blank?) && (params[:brand].blank?) && (params[:seller].blank?) &&(params[:price].blank?) 
      @products = Product.all
    else
      @products = Product.filter(params)
      @categories = Category.all
      @sellers = Store.all
      @brands = Brand.all
      @category_name = Category.find(params[:category]).name if params[:category].present?
      @brand_name = Brand.find(params[:brand]).name if params[:brand].present?
      @store_name = Store.find(params[:seller]).name if params[:seller].present?
      @price_range = params[:price].keys.first  if params[:price].present?
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @store = store_path(current_user.id)
    respond_to do |format|
      if @product.update(product_params)
        expire_page product_path(@product)
        format.html { redirect_to @store, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json  
  def destroy
    @product.update(is_deleted: true)
    @store = store_path(current_user.id)
    respond_to do |format|
      format.html { redirect_to @store, notice: 'Product was successfully deleted.' }
      format.json { head :no_content }
    end
  end
def test
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:brand_id, :category_id, :store_id, :title, :description, :image, :price, :quantity)
    end

end
