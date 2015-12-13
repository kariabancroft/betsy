require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:cart_items) do
    { product.id => 2 }
  end

  let(:product) do
    Product.create(name: "Stuff", price: 500, quantity: 5)
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

    it "renders checkout view again if given bad data" do
      post :create, bad_params
      expect(subject).to render_template :checkout
    end
  end

  describe "GET 'confirm'" do
    it "renders the order confirm page" do
      get :confirm
      expect(subject).to render_template :confirm
    end
  end
end
