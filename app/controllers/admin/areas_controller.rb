class Admin::AreasController < Admin::BaseController
  before_action :set_area, only: %i[show edit update destroy]

  def index
    @areas = Area.all.includes(:prefecture).order(id: :asc).page(params[:page]).per(25)
  end

  def new
    @area = Area.new
  end

  def create
    @area = Area.new(area_params)
    if @area.save
      redirect_to admin_areas_path, success: t('defaults.flash_message.created', item: Area.model_name.human)
    else
      flash.now[:error] = t('defaults.flash_message.not_created', item: Area.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @area.update(area_params)
      redirect_to admin_area_path(@area), success: t('defaults.flash_message.updated', item: Area.model_name.human)
    else
      flash.now[:error] = t('defaults.flash_message.not_updated', item: Area.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @area.destroy!
    redirect_to admin_areas_path, status: :see_other, success: t('defaults.flash_message.deleted', item: Area.model_name.human)
  end

  private

  def set_area
    @area = Area.find(params[:id])
  end

  def area_params
    params.require(:area).permit(:prefecture_id, :name)
  end
end
