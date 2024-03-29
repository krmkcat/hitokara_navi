class ProfilesController < ApplicationController
  before_action :set_profile

  def show; end

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to mypage_path, success: t('defaults.flash_message.updated', item: Profile.model_name.human)
    else
      flash.now[:error] = t('defaults.flash_message.not_updated', item: Profile.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = Profile.find_by(user_id: current_user.id)
  end

  def profile_params
    params.require(:profile).permit(:name, :gender, :age_group)
  end
end
