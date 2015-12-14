class OrdersController < ApplicationController
  before_action :require_login, only: [:index]

  def checkout
    # get @current_order info from carts controller
    @cart_items = session[:cart]
    # @cart_items looks like { "1" => 2 }
    # want instance_vars @p1, @p2, etc. set equal to the keys of the hash
    @order = Order.new
    @order_item = OrderItem.new
    @products = []
    if !@cart_items.nil?
      @cart_items.each do |k,v|
        product = Product.find(k.to_i)
        v.times { @products.push(product) }
      end
    end
    @order_total = 0
    @products.each do |product|
      @order_total += product.price
    end
  end

  def create
    @cart_items = session[:cart]
    @order = Order.new(order_params[:order])
    # this checks to make sure the products are still in stock before creating a new order
    # multiple sessions can have the same items in cart at the same time
    # if one session purchases, the other session's cart doesn't know about it
    @inventory_errors = []
    @cart_items.each do |k,v|
      product = Product.find(k.to_i)
      if product.quantity < v
        # stores error which will go into flash later
        error = "#{product.name} does not have sufficient stock to purchase. This item has been removed from your cart."
        @inventory_errors.push(error)
        # removes the sold out items from the cart
        discrepancy = (v - product.quantity).abs
        discrepancy.times do
          session[:cart][k] -= 1
        end
      end
    end
    # if there are no inventory problems and the cart isn't empty and the order saves
    if @inventory_errors.empty? && !@cart_items.nil? && @order.save
      # create order items
      @cart_items.each do |k,v|
        product = Product.find(k.to_i)
        OrderItem.create(
        order_id: @order.id,
        product_id: product.id,
        quantity: v
        )
        # decrement stock of purchased products
        new_product_quantity = product.quantity - v
        product.update(quantity: new_product_quantity)
        # update order status from pending to paid
        @order.update(status: "Paid")
      end
      # remove items from cart
      session[:cart] = nil
      redirect_to order_confirm_path(@order.id)
    else
      # tells guest which products were sold out and removed from cart
      if !@inventory_errors.empty?
        flash[:error] = @inventory_errors.join(", ")
      end
      redirect_to orders_checkout_path
    end
  end

  def confirm
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    # find total $ amount for order
    @order_total = 0
    @order_items.each do |item|
      product = Product.find(item.product_id)
      subtotal = product.price * item.quantity
      @order_total += subtotal
    end
  end

  def index
    # @merchant = Merchant.find(params[:merchant_id])

    # find all products for this merchant
    @products = current_merchant.products
    # find all order items for these products
    @orderitems = []

    @products.each do |product|
      @orderitems.push(product.order_items)
    end

    @orderitems = @orderitems.flatten

    # find all orders with those order items
    @orders = []
    @orderitems.each do |orderitem|
      @orders.push(orderitem.order)
    end

    @total_revenue = 0

    @orderitems.each do |orderitem|
      @total_revenue += Product.find(orderitem.product_id).price * orderitem.quantity
    end

  end

  def show

  end

  private

  def order_params
    params.permit(order:[:purchase_time, :name, :email, :street, :city, :state, :zip, :cc_num, :cc_exp, :sec_code, :bill_zip, :status])
  end

  def order_item_params

  end
end
