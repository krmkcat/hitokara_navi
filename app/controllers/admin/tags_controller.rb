class Admin::TagsController < Admin::BaseController
  before_action :set_tag, only: %i[show edit update destroy]

  def index
    @tags = Tag.all.order(id: :asc)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, success: t('defaults.flash_message.created', item: Tag.model_name.human)
    else
      flash.now[:error] = t('defaults.flash_message.not_created', item: Tag.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @tag.update(tag_params)
      redirect_to admin_tag_path(@tag), success: t('defaults.flash_message.updated', item: Tag.model_name.human)
    else
      flash.now[:error] = t('defaults.flash_message.not_updated', item: Tag.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy!
    redirect_to admin_tags_path, status: :see_other, success: t('defaults.flash_message.deleted', item: Tag.model_name.human)
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
