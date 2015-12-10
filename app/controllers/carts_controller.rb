class CartsController < ApplicationController
  before_action :cart_exists, only: [:add_item, :remove_item]

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
    @product = Product.find(id)
    # if product is not yet in cart, add one of it
    if session[:cart][id].nil?
      session[:cart][id] = 1
    # if trying to add more to cart than are in stock, flash error
  elsif session[:cart][id] + 1 > @product.quantity
      flash[:error] = "You cannot add more items than are in stock."
    # add another of product to cart
    else
      session[:cart][id] += 1
    end
    redirect_to product_path(@product.id)
  end

  def remove_item
    id = params[:id]
    @product = Product.find(id)
    if session[:cart][id].nil?
      flash[:error] = "This item has already been removed from your cart."
    else
      session[:cart][id] -= 1
    end
    redirect_to product_path(@product.id)
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
