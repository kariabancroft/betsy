class MerchantsController < ApplicationController
  def new
    # display the form to sign up as a merchant
    @merchant = Merchant.new
  end

  def create
    # create the new merchant then display merchant home page
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

  private

  def strong_params
    params.require(:merchant).permit(:username, :email, :password, :password_confirmation)
  end
end
