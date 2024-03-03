class ApplicationController < ActionController::Base
  before_action :require_login

  add_flash_types :success, :info, :warning, :error

  protected

  def not_authenticated
    redirect_to login_path, warning: t('defaults.flash_message.not_authenticated')
  end
end
