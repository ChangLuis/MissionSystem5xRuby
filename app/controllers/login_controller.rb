class LoginController < ApplicationController
  def new
    redirect_to role_direct if logged_in?
  end

  def create
    user = User.find_by(account: login_params[:account])
    if user&.authenticate(login_params[:password])
      session[:user_id] = user.id
      redirect_to role_direct, notice: "成功登入"
    else
      redirect_to login_path, notice: "帳號或密碼有問題"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "已成功登出"
  end

  private

  def login_params
    params.require(:login).permit(:account, :password)
  end

  def role_direct
    current_user.is_admin? ? admin_root_path : user_missions_path
  end
end
