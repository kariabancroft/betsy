class OrderItemsController < ApplicationController
  before_action :require_login

  def edit
    @orderitem = OrderItem.find(params[:id])
  end

  def update
    @orderitem = OrderItem.find(params[:id])
    @orderitem.update(order_items_params)
    redirect_to merchant_orders_path(@current_merchant.id)
  end

  private

  def order_items_params
    params.require(:order_item).permit(:status)
  end
end
