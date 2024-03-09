class ShopsController < ApplicationController
  skip_before_action :require_login

  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
  end
end
