class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    if params[:email].present?
      @user = User.find_by_email(params[:email])
      @user&.deliver_reset_password_instructions!
      redirect_to login_path, success: t('.success')
    else
      flash.now[:error] = t('.require_email')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?

    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.valid?(:reset_password) && @user.change_password(params[:user][:password])
      redirect_to login_path, success: t('.success')
    else
      flash.now[:error] = t('.failure')
      render :edit, status: :unprocessable_entity
    end
  end
end
