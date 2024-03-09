class ShopsController < ApplicationController
  skip_before_action :require_login
  before_action :set_shops

  def index
  end

  def show
  end

  private

  def set_shops
    @shops = Shop.all
  end
end
