class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.not_admin
    @admins = User.is_admin
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to admin_root_path, notice: "人員新增成功"
    else
      render :new
    end
  end

  def edit; end

  def show
    @user = User.fetch_specific_user params[:id]
    @search = @user.missions.ransack params[:q]
    @missions = params[:q] ? @search.result : @user.missions
    @pagy, @missions = pagy @missions
  end

  def update
    if @user.update user_params
      redirect_to login_path, notice: "人員更新成功"
    else
      render :edit
    end
  end

  def destroy
    redirect_to admin_root_path, notice: (@user.destroy ? "人員刪除成功" : "您是最後一位管理員，不能移除")
  end

  private

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:account, :name, :password, :password_confirmation, :is_admin)
  end
end
