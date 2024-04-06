class ApplicationController < ActionController::Base
  before_action :require_login

  add_flash_types :success, :info, :warning, :error

  def redirect_if_logged_in
    redirect_to(shops_path, error: t('defaults.flash_message.logged_in')) if logged_in?
  end

  protected

  def not_authenticated
    redirect_to login_path, error: t('defaults.flash_message.not_authenticated')
  end
end
