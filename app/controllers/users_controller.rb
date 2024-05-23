class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :redirect_if_logged_in, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    ActiveRecord::Base.transaction do
      if @user.save
        @user.create_profile!
        redirect_to root_path, success: t('.success')
      else
        flash.now[:error] = t('.failure')
        render :new, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  end

  def destroy
    user = current_user
    user.destroy!
    redirect_to root_path, status: :see_other, success: t('.success')
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
