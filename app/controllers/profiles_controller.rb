class ProfilesController < ApplicationController
  before_action :set_profile

  def show; end

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to mypage_path, success: 'プロフィールを更新しました'
    else
      flash.now[:error] = 'プロフィールの更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = User.find(current_user.id).profile
  end

  def profile_params
    params.require(:profile).permit(:name, :gender, :age_group)
  end
end
