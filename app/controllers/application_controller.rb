class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :merchants_for_navbar

  def current_merchant
    @current_merchant ||= Merchant.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_merchant
  # The helper_method line allows us to use @current_merchant in our view files.

  def require_login
    unless current_merchant
      flash[:error] = "Please log in to view this section."
      redirect_to new_session_path
    end
  end

  def merchants_for_navbar
    @merchants = Merchant.all
  end

end
