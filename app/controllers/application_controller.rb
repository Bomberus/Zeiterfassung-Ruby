class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?

  # before_action :authenticate!

  def logged_in?
    !session[:user].blank?
  end

  def authenticate!
    redirect_to login_path, notice: 'Please login' unless logged_in? || self.class == SessionController
  end
end
