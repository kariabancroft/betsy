class CartsController < ApplicationController
  before_action :create

  def create
    if cookies[:cart_id].nil?
      @current_cart = Cart.create
        { 1: 3,
          2: 6,
          3: 7
        }
      session[:cart_id] = @current_cart.id
    else
      @current_cart
    end
  end

  def destroy
    session[:cart_id] = nil
  end

  def show

  end

  def add_item
    @current_cart <<


    # include adding quantity
    if quantity <= product.quantity
      cookies[:current_cart].push({ product.id: quantity })
    else
      flash.now[:error] = "You cannot add more items than are in stock."
      render product_path(product.id)
    end

    # cookies[:current_cart] = [
    #     { 5: 3 },
    #     { 1: 20 },
    #     { 3: 1}
    # ]

  end

  def remove_item(product)

  end

  def change_quantity(product)
    # similar to upvote
  end

end
