class OrdersController < ApplicationController
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
    # do something with order items to make them accessible
    @purchased_products = []
    @order_items.each do |item|
      product = Product.find(item.product_id)
      quantity = item.quantity
      quantity.times { @purchased_products.push(product) }
    end
    # @purchased_products now looks like [Product.find(1), Product.find(1), Product.find(2)]
  end

  def index
    @current_merchant = Merchant.find(params[:merchant_id])

    # find all products for this merchant
    @products = @current_merchant.products

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
