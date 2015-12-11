class MerchantsController < ApplicationController
  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(strong_params)
      if @merchant.save
        redirect_to new_session_path
      else
        render :new
      end
  end

  def home
    if current_merchant.nil?
      flash[:error] = "You must be logged in to view this page."
      redirect_to new_session_path
    else
      render :home
    end
  end

  def show
    @merchant = Merchant.find(params[:id])
    @products = @merchant.products
  end

  private

  def strong_params
    params.require(:merchant).permit(:username, :email, :password, :password_confirmation)
  end
end
