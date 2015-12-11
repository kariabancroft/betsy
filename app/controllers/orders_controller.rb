class OrdersController < ApplicationController
  def checkout
    # get @current_order info from carts controller
    @cart_items = session[:cart]
    # @cart_items looks like { "1" => 2 }
    # want instance_vars @p1, @p2, etc. set equal to the keys of the hash
    @products = []
    @cart_items.each do |k,v|
      product = Product.find(k.to_i)
      v.times { @products.push(product) }
    end
    @order = Order.new
    @order_item = OrderItem.new
    @order_total = 0
    @products.each do |product|
      @order_total += product.price
    end
  end

  def create
    @order = Order.create(order_params)
    @order_item = OrderItem.create()
    if @order.save
      redirect_to @order
    else
      render action: 'new'
    end
  end

  def confirm
  end

  private

  def order_params
    params.permit(order:[:purchase_time, :name, :email, :street, :city, :state, :zip, :cc_num, :cc_exp, :sec_code, :bill_zip])
  end
end
