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
  {merchant_id: 1,
    id: 1,
    product: {
      name: "Catfish",
      price: 2,
      description: "new description"
    }
  }
  end

  let :bad_params do
    {merchant_id: 1,
      id: 1,
      product: {
        name: "",
      }
    }
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

  let :good_review do
    {product_id: 1,
     id: 1,
      review: {
        rating: 3,
        description: "Aight",
    }
  }
  end

  describe "GET #index" do
    it "is successful" do
      get :index, merchant_id: @product.merchant_id
      expect(response.status).to eq 200
    end
  end

  describe "GET 'new'" do
    it "is renders new view" do
      get :new, merchant_id: @product.merchant_id
      expect(response.status).to eq 200
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

  describe 'GET #edit' do
    it "renders edit template" do
    get :edit, merchant_id: @product.merchant_id, id: @product.id
    expect(subject).to render_template :edit
    end
  end

  describe "PATCH #update" do
    it "goes to the product index page when successful" do
      patch :update, update_params
      expect(subject).to redirect_to merchant_products_path(@product.merchant_id)
    end
    it "renders the edit view when unsuccessful" do
      patch :update, bad_params
      expect(subject).to render_template :edit,(@product.id)
    end
  end


  describe "DESTROY #destroy" do
    it "redirects to merchant index page" do
      delete :destroy, update_params
      expect(subject).to redirect_to merchant_products_path(@product.merchant_id)
      end
    end

  # describe "#create a review" do
  #   it "redirects to product show page" do
  #     @review = Review.create(rating: 3, description: "good!", product_id: 1)
  #     post :create, product_id: 1
  #     expect(subject).redirect_to product_path(product_id)
  #   end
  # end
end
