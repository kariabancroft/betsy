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
    @reviews = @product.reviews
    @review = Review.new
    @can_review = current_merchant_product?
  end

  def edit
    current_merchant
    @product = Product.find(params[:id])
    @action = "update"
    @method = :patch
  end

  def update
    @product = Product.update(params[:id], product_params)
    if @product.save
      redirect_to merchant_products_path
    else
      render :edit
    end
  end

  def destroy
   Product.find(params[:id]).destroy
   redirect_to merchant_products_path(params[:merchant_id])
  end

  def create_review
    @review = Review.create(review_params)
    redirect_to product_path(@review.product.id)
  end

  private

  def current_merchant_product?
    if current_merchant.nil?
      return true
    else
      current_merchant.products.each do |product|
        if product.id == params[:id].to_i
          return false
        else
          return true
        end
      end
    end
  end

  def product_params
    params.require(:product).permit(:name, :price, :image, :photo_url, :description, :quantity, {category_ids:[]})
  end

  def review_params
    params.require(:review).permit(:rating, :description, :product_id)
  end

end
