require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  before(:each) do
    @merchant = Merchant.create(username: "Seabay", email: "info@seabay.com", password: "password", password_confirmation: "password")
  end

  describe "POST 'create'" do
    let (:session_data) do
      {
        email: "info@seabay.com",
        username: "Seabay",
        password: "password"
      }
    end

    it "creates an authenticated session" do
      merchant = Merchant.find_by_username(session_data[:username])
      post :create, :session_data => session_data
      expect(response).to redirect_to merchant_home_path(merchant.id)
    end
  end

  #   it "redirects to merchant index page" do
  #     post :create, create_params
  #     new_object = medium_class.last
  #     expect(subject).to redirect_to send(medium_path,*new_object.id)
  #   end
  #
  #   it "renders new template on error" do
  #     post :create, bad_params
  #     expect(subject).to render_template :new
  #   end
  # end

  describe "DELETE #destroy" do
    it "allows merchant to log out" do
      session[:user_id] = @merchant.id
      delete :destroy
      expect(session[:user_id]).to eq(nil)
    end
  end

  # describe "cart" do
  #   it "sets the cart value in the cookies" do
  #     # expect(cookies[:cart].to
  #   end
  # end 
end
