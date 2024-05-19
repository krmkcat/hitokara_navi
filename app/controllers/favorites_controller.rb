class FavoritesController < ApplicationController
  before_action :set_shop

  def create
    current_user.favorite(@shop)
  end

  def destroy
    current_user.unfavorite(@shop)
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end
end
