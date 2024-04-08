class Admin::BaseController < ApplicationController
  layout 'admin/layouts/application'
  before_action :check_admin

  private

  def not_authenticated
    redirect_to admin_login_path, error: t('defaults.flash_message.not_authenticated')
  end

  def check_admin
    return if current_user.admin?

    redirect_to root_path, error: t('defaults.flash_message.not_authorized')
  end
end
