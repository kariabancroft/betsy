require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:cart_items) do
    { product.id => 2 }
  end

  let(:product) do
    Product.create(name: "Stuff", price: 500)
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
end
