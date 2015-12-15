require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:cart_items) do
    { product.id => 2 }
  end

  let(:product) do
    Product.create(name: "Stuff", price: 500, quantity: 5)
  end

  let(:order) do
    Order.create(:good_params)
  end

  let(:good_params) do
    {order: {
      name: "Katherine",
      email: "kdefliese@gmail.com",
      street: "123 Ada St",
      city: "Seattle",
      state: "WA",
      zip: 12345,
      cc_num: 1234,
      cc_exp: Time.now.to_date,
      sec_code: 123,
      bill_zip: 12345,
      status: "Pending",
      purchase_time: Time.now
      }
    }
  end

  let(:bad_params) do
    {order: {
      name: nil,
      email: nil,
      street: nil,
      city: nil,
      state: nil,
      zip: nil,
      cc_num: nil,
      cc_exp: nil,
      sec_code: nil,
      bill_zip: nil,
      status: nil,
      purchase_time: nil
      }
    }
  end

  let(:good_merchant_params) do
    {merchant: {
      username: "kdefliese",
      email: "kdefliese@gmail.com",
      password: "cats",
      password_confirmation: "cats"}
    }
  end

  let(:session_data) do
    {
      email: "info@kdefliese.com",
      username: "kdefliese",
      password: "cats"
    }
  end

  let(:merchant) do
    Merchant.create(good_merchant_params[:merchant])
  end

  let(:orderitem) do
    OrderItem.create(quantity: 3, order_id: 1, status: "shipped")
  end

  before :each do
    session[:cart] = cart_items
  end

  describe "GET 'checkout'" do
    it "renders the checkout page" do
      get :checkout
      expect(subject).to render_template :checkout
    end
  end

  describe "POST 'create'" do
    it "redirects to order confirm view" do
      post :create, good_params
      expect(subject).to redirect_to order_confirm_path(1)
    end

    it "redirects to the checkout view if given bad data" do
      post :create, bad_params
      expect(subject).to redirect_to orders_checkout_path
    end

    it "redirects to the checkout view if products are out of stock" do
      unavailable_product = Product.create(name: "Stuff 2", price: 500, quantity: 0)
      session[:cart][unavailable_product.id] = 1
      post :create, good_params
      expect(subject).to redirect_to orders_checkout_path
    end
  end

  describe "GET 'confirm'" do
    it "renders the order confirm page" do
      order = Order.create(good_params[:order])
      get :confirm, id: order.id
      expect(subject).to render_template :confirm
    end

    it "shows order items on the order confirm page" do
      @purchased_products = [Product.find(1), Product.find(1)]
      expect(@purchased_products).to be_an Array
    end
  end

  describe "GET 'index'" do
    it "renders the index page for merchants to see their orders" do
      # log in merchant
      merchant.authenticate(session_data)
      session[:user_id] = merchant.id
      merchant.products << product
      product.order_items << orderitem
      binding.pry
      get :index, merchant_id: merchant.id
      expect(subject).to render_template :index
    end

  end
end
