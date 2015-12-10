class ProductsController < ApplicationController

  # @product = Product.find(params[:id])
  def index
    current_merchant
  end

  def new
    @product = Product.new
    @action = "create"
    @method = :post
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to merchant_products_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
  end

  def edit
    @title = "Edit your product"
    @action = :update
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :photo_url, :description, :quantity)
  end

end
