require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #index" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
    end
    # some test about current_merchant
  end

  describe "GET #new" do
    it "renders new view" do
    get :new
    expect(subject).to render_template :new
    end
  end

  # def new
  #   current_merchant
  #   @product = Product.new
  #   @action = "create"
  #   @method = :post
  # end

end
