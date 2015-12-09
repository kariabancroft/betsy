class MerchantsController < ApplicationController
  def new
    # display the form to sign up as a merchant
    @merchant = Merchant.new
  end

  def create
    # create the new merchant then display merchant home page
    @merchant = Merchant.new(strong_params)
      if @merchant.save
        redirect_to merchant_home_path(@merchant.id)
      else
        render :new
      end
  end

  def home
    @merchant = Merchant.find(params[:id])
  end

  private

  def strong_params
    params.require(:merchant).permit(:username, :email, :password, :password_confirmation)
  end
end
