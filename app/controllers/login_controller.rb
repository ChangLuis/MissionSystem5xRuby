class LoginController < ApplicationController
  def new; end

  def create
    user = User.find_by(account: login_params[:account])
    if user&.authenticate(login_params[:password])
      session[:user_id] = user.id
      redirect_to user_missions_path, notice: "成功登入"
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
end
