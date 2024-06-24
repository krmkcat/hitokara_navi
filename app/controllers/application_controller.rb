class ApplicationController < ActionController::Base
  before_action :require_login
  add_flash_types :success, :info, :warning, :error

  NUM_OF_REVIEWS_FOR_GOLD = 15
  NUM_OF_REVIEWS_FOR_SILVER = 7
  NUM_OF_REVIEWS_FOR_BRONZE = 3

  def redirect_if_logged_in
    redirect_to(my_page_path) if logged_in?
  end

  protected

  def not_authenticated
    redirect_to login_path, error: t('defaults.flash_message.not_authenticated')
  end
end
