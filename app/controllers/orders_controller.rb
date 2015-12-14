class OrdersController < ApplicationController
  before_action :require_login, only: [:index, :pending, :cancelled, :paid, :completed]

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
    # product quantity must be sufficient before you can save the order - how to do?
    if !@cart_items.nil? && @order.save
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
      render action: 'checkout'
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
    # find all products for current merchant
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

  def status
    # find all products for current merchant
    @products = current_merchant.products
    # find all order items for these products
    @all_orderitems = []

    @products.each do |product|
      @all_orderitems.push(product.order_items)
    end

    @all_orderitems = @all_orderitems.flatten

    # find all orders with those order items
    @orders = []
    @all_orderitems.each do |orderitem|
      @orders.push(orderitem.order)
    end

    @orderitems = []
    @total_revenue = 0
    @status = params[:status]

    if @status == "pending"
      @all_orderitems.each do |oi|
        if oi.order.status == "Pending"
          @orderitems.push(oi)
        end
      end

    elsif @status == "paid"
      @all_orderitems.each do |orderitem|
        if orderitem.order.status == "Paid"
          @orderitems.push(orderitem)
        end
      end
      @orderitems.each do |orderitem|
        @total_revenue += Product.find(orderitem.product_id).price * orderitem.quantity
      end
    elsif @status == "completed"
      @all_orderitems.each do |orderitem|
        if orderitem.order.status == "Completed"
          @orderitems.push(orderitem)
        end
      end
      @orderitems.each do |orderitem|
        @total_revenue += Product.find(orderitem.product_id).price * orderitem.quantity
      end
    elsif @status == "cancelled"
      @all_orderitems.each do |orderitem|
        if orderitem.order.status == "Cancelled"
          @orderitems.push(orderitem)
        end
      end
      @orderitems.each do |orderitem|
        @total_revenue += Product.find(orderitem.product_id).price * orderitem.quantity
      end
    end
  end

  private

  def order_params
    params.permit(order:[:purchase_time, :name, :email, :street, :city, :state, :zip, :cc_num, :cc_exp, :sec_code, :bill_zip, :status])
  end

  def order_item_params

  end
end
