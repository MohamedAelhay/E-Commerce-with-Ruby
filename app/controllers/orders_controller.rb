class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :total_price, :total_before_shipping, :total_after_shipping]
  before_action :set_order_product, only: [:remove_product]
  # load_and_authorize_resource

  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    if ( Order.find_by(id: params[:id]).state == "cart" )
      @orders = Order.find_by(user_id: current_user.id, state: "cart")

      @status = "cart"

      @single_order_products = OrderProduct.where(order_id: @orders.id)
      @each_total = []
      @single_order_products.each do |single_product|
        @each_total.push(calculate_total_price(single_product))
      end

      @total_before = calculate_products_total(@orders)
      
    
      @total_after_discount = 0

      
      @total_after = calculate_total_after_shipping(@total_before)

    else
      @total_price = Order.find_by(id: params[:id]).total_price
      @order_products = OrderProduct.where(order_id: params[:id])

      @status = "not cart"
    end

  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    authorize! :edit, @order
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
  def check_out
   @order=Order.find_by(id: params[:id])
   @total_price=@total_after_discount=calculate_products_total(@order)
   @with_coupon=false
   if((params[:submit_coupon]!="") && Coupon.isValid(params[:submit_coupon]))
      if(!UserCoupon.taken_before(current_user.id,params[:submit_coupon]))
        @total_after_discount=Coupon.after_discount(@total_price,params[:submit_coupon])
        @with_coupon=true
      end
   end
   if( @with_coupon)
      @coupon=Coupon.find_by(code: params[:submit_coupon])
      @order.coupon_id=@coupon.id
         if(@coupon.usage_number)
           @coupon.decrement(:usage_number, 1)
           @coupon.save
         end
    end
   @order.order_date=Time.now 
   @order.address=params[:address]
   @order.total_price=@total_price
   @order.total_price_after_discount=@total_after_discount
   @order.state="pending"
   @order.save
   redirect_to "/orders"
  end 
  def remove_product
    @order_product[0].destroy
    redirect_to order_path(@order_product[0].order_id)
  end

  def calculate_total_price(single_product)
    total_price = 0.00
    total_price = (single_product.Product_quantity) * (single_product.product.price)
    total_price.to_f
  end

  def calculate_products_total(orders)
    total_price = 0.00
    orders.order_products.each do |prod|
      total_price += (prod.Product_quantity * prod.product.price)
    end
    total_price.to_f
  end

  def calculate_total_after_shipping(total_before)
    total_price = 2.00 + total_before
    total_price.to_f
  end
  def add_to_cart
    if(!current_user)
      redirect_to "/users/sign_in"
      return
    end
    @lastOrder=current_user.orders.last
    if(@lastOrder.nil? || @lastOrder.state !="cart")
      @order=current_user.orders.new(:state => "cart")
      @order.save
    end  
    @product=current_user.orders.last.order_products.find_by(product_id: params[:id])
    if(@product.nil?) 
      @product=current_user.orders.last.order_products.new(product_id: params[:id],	Product_quantity: 1)
      @product.save
    else
      @product.increment(:Product_quantity,1) 
      @product.save
    end 
    render json:   @product.Product_quantity
  end
  def removeFromCart
    if(!current_user)
      redirect_to "/users/sign_in"
      return
    end
    @new_quantity=0
    @orders=current_user.orders
     if(@orders.size >0 && @orders.last.state=="cart")
        @cart=@orders.last
        @product= @cart.order_products.find_by(product_id: params[:id])
        if(!@product.nil?)
            if(@product.Product_quantity>1)
                @product.decrement(:Product_quantity,1)
                @product.save
                @new_quantity=@product.Product_quantity
            elsif(@product.Product_quantity==1) 
                @product.destroy
                @product.save   
            end
        end
     end
    render json:  @new_quantity
  end

  def quantity_operations
    @order = current_user.orders.last
    if @order.state == "cart"
      @product = @order.order_products.find_by(product_id: params[:product_id])
      if (params[:operator] === "+")
        @product.increment(:Product_quantity,1)
        if (@product.Product_quantity >= Product.find_by(id: params[:product_id]).quantity)
          @limit_exceed = "Limit exceeded"
        end
        @product.save
      elsif (params[:operator] === "-")
        if (@product.Product_quantity > 1)
          @product.decrement(:Product_quantity,1)
          @product.save
        else
          @product.destroy
          @product.save
          if (@order.order_products.size == 0)
            redirect_to "/"
            return
          end
        end
      end
    end
    redirect_to "/orders/#{params[:id]}"
    return
  end

  def apply_coupon
    if ( Order.find_by(id: params[:id]).state == "cart" )
      @orders = Order.find_by(user_id: current_user.id, state: "cart")

      @status = "cart"

      @single_order_products = OrderProduct.where(order_id: @orders.id)
      @each_total = []
      @single_order_products.each do |single_product|
        @each_total.push(calculate_total_price(single_product))
      end

      @total_before = calculate_products_total(@orders)
      
    
      @total_after_discount = validate_coupon(params[:coupon_code],@total_before)

      
      @total_after = calculate_total_after_shipping(@total_before)

    else
      @total_price = Order.find_by(id: params[:id]).total_price
      @order_products = OrderProduct.where(order_id: params[:id])

      @status = "not cart"
    end
    render json: @total_after_discount

  end

  def validate_coupon(code,total_before)
      @is_taken = false
      @is_valid = true
      @new_total = 0.00
      if Coupon.isValid(code)
        # if code is valid
        if UserCoupon.taken_before(current_user.id,code)
          #if code is taken before
          @is_taken = true
        else
          #if code is not taken before
          @new_total = Coupon.after_discount(total_before,code).to_f
        end
        @is_valid = true
        @new_total
      else
        #if code is not valid
        @is_valid = false
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def set_order_product
      @order_product = OrderProduct.where(order_id: params[:format], product_id: params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :coupon_id, :state, :order_date, :confirmation_date, :deliverable_date, :address, :total_price, :total_price_after_discount)
    end


end
