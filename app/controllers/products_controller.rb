class ProductsController < ApplicationController

  def index
    current_merchant
  end

  def new
    current_merchant
    @product = Product.new
    @action = "create"
    @method = :post
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    @product = merchant.products.new(product_params)
    if @product.save
      redirect_to merchant_products_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    current_merchant
    @product = Product.find(params[:id])
    @action = "update"
    @method = :patch
  end

  def update
    # merchant = Merchant.find(params[:merchant_id])
    @product = Product.update(params[:id], product_params)
    if @product.save
      redirect_to merchant_products_path
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :photo_url, :description, :quantity)
  end

end
