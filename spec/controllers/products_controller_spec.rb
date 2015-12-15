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

  let(:merchant) do
    Merchant.create(username: "Apple", email: "email345@email.com", password: "password", password_confirmation: "password")
  end

  let(:session_data) do
    {
      username: "Apple",
      password: "password"
    }
  end

  let :good_review do
    {
      review: {
        rating: 3,
        description: "Aight",
        product_id: 1
    }
  }
  end

  describe "GET #index" do
    it "is successful" do
      merchant.authenticate(session_data)
      session[:user_id] = merchant.id
      get :index, merchant_id: @product.merchant_id
      expect(response.status).to eq 200
    end
  end

  describe "GET 'new'" do
    it "is renders new view" do
      merchant.authenticate(session_data)
      session[:user_id] = merchant.id

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
    it "redirects to merchant_products path" do
      @merchant = Merchant.create(username: "Bobbby", email: "email@email.com", password: "password", password_confirmation: "password")
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
    merchant.authenticate(session_data)
    session[:user_id] = merchant.id
    get :edit, update_params
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


  describe "create a review" do
    it "redirects to product show page" do
      post :create_review, good_review
      expect(subject).to redirect_to product_path(good_review.product_id)
      # expect(Review.count).to eq(1)
    end
  end

  describe "retire a product" do
    it "redirects to merchant index page" do
      merchant.authenticate(session_data)
      session[:user_id] = merchant.id
       patch :retire, update_params
       expect(subject).to redirect_to merchant_products_path(@product.merchant_id)
    end
  end

  describe "activate a product" do
    it "redirects to merchant index page" do
      merchant.authenticate(session_data)
      session[:user_id] = merchant.id
       patch :activate, update_params
       expect(subject).to redirect_to merchant_products_path(@product.merchant_id)
    end
  end
end
