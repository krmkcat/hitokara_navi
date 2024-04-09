class Admin::ShopsController < Admin::BaseController
  before_action :set_shop, only: %i[show edit update destroy]

  def index
    @shops = Shop.all.includes(:area, :prefecture).order(created_at: :desc)
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to admin_shops_path, success: t('defaults.flash_message.created', item: Shop.model_name.human)
    else
      flash.now[:error] = t('defaults.flash_message.not_created', item: Shop.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @shop.update(shop_params)
      redirect_to admin_shop_path(@shop), success: t('defaults.flash_message.updated', item: Shop.model_name.human)
    else
      flash.now[:error] = t('defaults.flash_message.not_updated', item: Shop.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shop.destroy!
    redirect_to admin_shops_path, status: :see_other, success: t('defaults.flash_message.deleted', item: Shop.model_name.human)
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:area_id, :name, :address, :phone_number, :url, :opening_hous, :latitude, :longitude)
  end
end
