class Admin::BaseController < ApplicationController
  before_action :require_login
  before_action :require_admin_role

  private

  def require_admin_role
    redirect_to login_path, notice: "您不是管理者身份" unless current_user.is_admin?
  end
end
