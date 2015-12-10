class OrdersController < ApplicationController
  def checkout
    # get @current_order info from carts controller
    @cart_items = session[:cart]
    @order = Order.new
  end

  def confirm
    @order = Order.create(order_params)
    @order_item = OrderItem.create()
    if @order.save
      redirect_to @order
    else
      render action: 'new'
    end
  end

  private

  def order_params
    params.permit(order:[:purchase_time, :name, :email, :street, :city, :state, :zip, :cc_num, :cc_exp, :sec_code, :bill_zip])
  end
end
