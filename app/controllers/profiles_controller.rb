class ProfilesController < ApplicationController
  before_action :set_my_profile, only: %i[edit update]

  def show
    @profile = Profile.find_by(user_id: params[:user_id])
  end

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to my_page_path, success: t('defaults.flash_message.updated', item: Profile.model_name.human)
    else
      flash.now[:error] = t('defaults.flash_message.not_updated', item: Profile.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_my_profile
    @profile = Profile.find_by(user_id: current_user.id)
  end

  def profile_params
    params.require(:profile).permit(:name, :gender, :age_group)
  end
end
