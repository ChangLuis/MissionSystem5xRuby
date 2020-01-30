class User::BaseController < ApplicationController
  before_action :require_login
  before_action :require_user_role

  private

  def require_user_role
    redirect_to login_path, notice: "您不是一般使用者" if current_user.is_admin?
  end
end
