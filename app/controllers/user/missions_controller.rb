class User::MissionsController < User::BaseController
  before_action :set_mission, except: [:index, :new, :create]

  def index
    @search = fetch_missions.ransack params[:q]
    @missions = params[:q] ? @search.result : fetch_missions
    @pagy, @missions = pagy @missions
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new mission_params
    @mission.user_id = session[:user_id]
    if @mission.save
      redirect_to user_missions_path, notice: t('mission.create.notice')
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @mission.update mission_params
      redirect_to user_missions_path, notice: t('mission.edit.notice')
    else
      render :edit
    end
  end

  def destroy
    @mission.destroy
    redirect_to user_missions_path, notice: t('mission.destroy.notice')
  end

  private

  def mission_params
    params.require(:mission).permit(
      :title, :contents, :status, :priority_order, :initial_time_at, :finish_time_at
    )
  end

  def set_mission
    @mission = Mission.find params[:id]
  end

  def fetch_missions
    Mission.get_list session[:user_id]
  end
end
