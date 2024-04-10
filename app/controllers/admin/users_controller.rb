class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all.includes(:profile).order(created_at: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), success: t('defaults.flash_message.updated', item: User.model_name.human)
    else
      flash.now[:error] = t('defaults.flash_message.not_updated', item: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    if request.referer&.include?('/admin/users/index')
      flash.now[:success] = t('defaults.flash_message.deleted', item: User.model_name.human)
      render :destroy
    else
      redirect_to admin_users_path, status: :see_other, success: t('defaults.flash_message.deleted', item: User.model_name.human)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :role, :password, :password_confirmation)
  end
end
