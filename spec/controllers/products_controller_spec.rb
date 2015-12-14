require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  before :each do
    @product = Product.create(name: "starfish", price: 3, merchant_id: 1, description: "A starfish!")
  end

  let :create_params do
  {merchant_id: 1,
    product: {
      name: "Dogfish",
      price: 2,
      description: "new description"
    }
  }
  end

  let :update_params do
  {
    product: {
      name: "Catfish",
      price: 2,
      merchant_id: 3,
      description: "new description"
    }
  }
  end

  let :bad_params do
    {merchant_id: 1,
      product: {
        name: "",
      }
    }
  end

  describe "GET #index" do
    it "is successful" do
      get :index, merchant_id: @product.merchant_id
      expect(response.status).to eq 200
    end
  end

  describe "GET #new" do
    it "renders new view" do
    get :new, merchant_id: @product.merchant_id
    expect(subject).to render_template :new
    end
  end

  describe "GET #show" do
    it "renders show view" do
      get :show, merchant_id: @product.merchant_id, id: @product.id
      expect(subject).to render_template :show
    end
  end

  describe "POST #create" do
    @merchant = Merchant.create(username: "Bobbby", email: "email@email.com", password: "password", password_confirmation: "password")
    it "redirects to merchant_products path" do
      post :create, create_params
      expect(subject).to redirect_to merchant_products_path(@product.merchant_id)
    end

    it "renders new template on error" do
      post :create, bad_params
      expect(subject).to render_template :new,(@product.merchant_id)
    end
  end

  describe "PATCH #update" do
    @merchant = Merchant.update()
  end
end

#   describe "DESTROY #destroy" do
#
#   end
#
#   def destroy
#    Product.find(params[:id]).destroy
#    redirect_to merchant_products_path(params[:merchant_id])
#   end
#
#   describe "#create_review" do
#
#   end
#
#   def create_review
#     @review = Review.create(review_params)
#     redirect_to product_path(@review.product.id)
#   end
#
#   describe "current_merchant_product" do
#
#   end
#
#   private
#
#   def current_merchant_product?
#     if current_merchant.nil?
#       return true
#     else
#       current_merchant.products.each do |product|
#         if product.id == params[:id].to_i
#           return false
#         else
#           return true
#         end
#       end
#     end
#   end
#
#   def product_params
#     params.require(:product).permit(:name, :price, :image, :description, :quantity, {category_ids:[]})
#   end
#
#   def review_params
#     params.require(:review).permit(:rating, :description, :product_id)
#   end
#
# end

  # merchant = Merchant.find(params[:merchant_id])
  # @product = merchant.products.new(product_params)
  # if @product.save
  #   redirect_to merchant_products_path
  # else
  #   render :new
  # end
