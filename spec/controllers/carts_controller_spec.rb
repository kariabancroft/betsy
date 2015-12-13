require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:product) do
    Product.create(name: "Stuff", price: 500, quantity: 5)
  end

  describe "GET 'index'" do
    it "shows the cart index view" do
      get :index
      expect(subject).to render_template :index
    end
  end

  describe "DELETE 'destroy'" do
    it "redirects to the home page" do
      delete :destroy, cart_id: 1
      expect(subject).to redirect_to root_path
    end
  end

  describe "POST 'add_quantity'" do
    it "redirects to the cart page" do
      post :add_quantity, product_id: product.id
      expect(subject).to redirect_to carts_path
    end
  end

  describe "POST 'remove_quantity'" do
    it "redirects to the cart page" do
      post :remove_quantity, product_id: product.id
      expect(subject).to redirect_to carts_path
    end
  end

end
