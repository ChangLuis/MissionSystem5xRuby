class ApplicationController < ActionController::Base
  include Pagy::Backend
  helper_method :current_user, :logged_in?

  def current_user
    user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def require_login
    redirect_to login_path, notice: "您還未登入" unless logged_in?
  end
end
