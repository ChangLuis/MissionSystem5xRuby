class User::MissionsController < ApplicationController
  def index
    @missions = Mission.all
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new mission_params
    @mission.user_id = 1
    if @mission.save
      redirect_to user_missions_path, notice: "Create sucessfully!"
    else
      render :new
    end
  end

  def show
    @mission = Mission.find params[:id]
  end

  def edit
    @mission = Mission.find params[:id]
  end

  def update
    @mission = Mission.find params[:id]
    if @mission.update mission_params
      redirect_to user_missions_path, notice: "Update successfully!"
    else
      render :edit
    end
  end

  def destroy
    @mission = Mission.find params[:id]
    @mission.destroy
    redirect_to user_missions_path, notice: "Destroy successfully!"
  end

  private

  def mission_params
    params.require(:mission).permit(
      :title, :contents, :status, :priority_order, :initial_time_at, :finish_time_at
    )
  end
end
