class OrderItemsController < ApplicationController
  before_action :require_login

  def edit
    @orderitem = OrderItem.find(params[:id])
  end

  def update

  end
end
