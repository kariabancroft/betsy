require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:product) do
    Product.create(name: "Stuff", price: 500, quantity: 5)
  end

  describe "POST 'create'" do
    it "gets a success response when creating a new cart" do
      expect(response.status).to eq 200
    end
  end

  describe "DELETE 'destroy'" do
    it "redirects to the home page" do
      delete :destroy, id: 1
      expect(subject).to redirect_to root_path
    end
  end

  describe "GET 'index'" do
    it "shows the cart index view" do
      get :index
      expect(subject).to render_template :index
    end
  end

  describe "POST 'add_quantity'" do
    it "redirects to the cart page if product was not yet in cart" do
      post :add_quantity, product_id: product.id
      expect(subject).to redirect_to carts_path
    end

    it "gives flash error if you try to add an item that is out of stock" do
      unavailable_product = Product.create(name: "Stuff", price: 500, quantity: 0)
      post :add_quantity, product_id: unavailable_product.id
      expect(flash[:error]).to eq "You cannot add more items than are in stock."
    end

  end


  describe "POST 'remove_quantity'" do
    it "redirects to the cart page" do
      post :remove_quantity, product_id: product.id
      expect(subject).to redirect_to carts_path
    end
  end

end
