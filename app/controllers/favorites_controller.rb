class FavoritesController < ApplicationController
  def index
    @shops = current_user.shops.page(params[:page])
  end

  def create
    @shop = Shop.find(params[:shop_id])
    current_user.favorite(@shop)
  end

  def destroy
    @shop = current_user.favorites.find(params[:id]).shop
    current_user.unfavorite(@shop)
  end
end
