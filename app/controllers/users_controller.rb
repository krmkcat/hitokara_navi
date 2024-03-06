class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    ActiveRecord::Base.transaction do
      if @user.save
        @user.create_profile!
        redirect_to root_path, success: '会員登録に成功しました'
      else
        flash.now[:error] = '会員登録に失敗しました'
        render :new, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
