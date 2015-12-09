class ProductsController < ApplicationController

  @product = Product.find(params[:id])

  def new
    @title = "Create a product"
    @new_prod = Product.new
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
  end

  def edit
    @title = "Edit your product"
    @action = :update
  end

  private

  def product_params
    params.permit(category:[:id, :name, :price, :photo_url, :description, :quantity])
  end

end
