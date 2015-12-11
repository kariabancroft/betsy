require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:cart_items) do
    { "1" => 2 }
  end

  describe "GET 'checkout'" do
    it "renders the checkout page" do
      get :checkout, cart_items
      expect(subject).to render_template :checkout
    end
  end
end
