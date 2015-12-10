class CartsController < ApplicationController
  before_action :cart_exists, only: :add_item

  def create
    session[:cart] = {}
  end

  def destroy
    session[:cart] = nil
    redirect_to root_path
  end

  def index
    @cart_items = session[:cart]
  end

  def add_item
    id = params[:id]

    # if product is not yet in cart, add one of it
    if session[:cart][id].nil?
      session[:cart][id] = 1
    # if trying to add more to cart than are in stock, flash error
    elsif session[:cart][id]
      flash.now[:error] = "You cannot add more items than are in stock."
      # render product_path(product.id)
    # add another of product to cart
    else
      session[:cart][id] += 1
    end

    redirect_to carts_path

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
