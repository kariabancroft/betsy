class ProductsController < ApplicationController

  # @product = Product.find(params[:id])
  def index
    current_merchant
  end

  def new
    @title = "Create a product"
    @product = Product.new
    @action = :create
  end

  def create
    @create_product = Product.new(product_params[:product])
    if @create_product.save
      redirect_to product_path(@create_product)
    else
      render "new"
    end
  end

  def show
    @product = Product.find(params[:id])
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
