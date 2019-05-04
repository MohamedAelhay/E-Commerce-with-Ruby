class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :total_price, :total_before_shipping, :total_after_shipping]
  before_action :set_order_product, only: [:remove_product]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.find_by(user_id: current_user.id, state: "cart")
    @order_products = OrderProduct.all
    @products = Product.all

    @single_order_products = OrderProduct.where(order_id: 1)
    @each_total = []
    @single_order_products.each do |single_product|
      @each_total.push(total_price(single_product))
    end

    @total_before = total_before_shipping(@orders)
    @total_after = total_after_shipping(@total_before)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_product
    @order_product.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Product was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def total_price(single_product)
    total_price = 0.00
    total_price = (single_product.Product_quantity) * (single_product.product.price)
    total_price.to_f
  end

  def total_before_shipping(orders)
    total_price = 0.00
    orders.order_products.each do |prod|
      total_price += (prod.Product_quantity * prod.product.price)
    end
    total_price.to_f
  end

  def total_after_shipping(total_before)
    total_price = 2.00 + total_before
    total_price.to_f
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def set_order_product
      @order_product = OrderProduct.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :coupon_id, :state, :order_date, :confirmation_date, :deliverable_date, :address, :total_price, :total_price_after_discount)
    end


end
