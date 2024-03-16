class ShopTagsController < ApplicationController
  before_action :set_shop, only: %i[index create]

  def index; end

  def create
    @tag = Tag.find(params[:tag_id])
    @shop.add_tag(@tag)
  end

  def destroy
    shop_tag = ShopTag.find(params[:id])
    @tag = shop_tag.tag
    @shop = shop_tag.shop
    @shop.remove_tag(@tag)
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end
end
