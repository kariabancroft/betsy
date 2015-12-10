class CartsController < ApplicationController
  before_action :cart_exists

  def create
    session[:cart] = {}
  end

  def destroy
    session[:cart] = nil
  end

  def index
    @cart_items = session[:cart]
  end

  def add_item
    id = params[:id]

    if session[:cart][id].nil?
      session[:cart][id] = 1
    else
      session[:cart][id] += 1
    end

    redirect_to carts_path


    # include adding quantity
    # if quantity <= product.quantity
    #   cookies[:current_cart].push({ product.id: quantity })
    # else
    #   flash.now[:error] = "You cannot add more items than are in stock."
    #   render product_path(product.id)
    # end

  end

  def remove_item(product)

  end

  def change_quantity(product)
    # similar to upvote
  end

  private

  def cart_exists
    if session[:cart].nil?
      create
    end
  end

end
