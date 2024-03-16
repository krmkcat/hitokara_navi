class ShopTagsController < ApplicationController
  before_action :set_shop, only: %i[edit create]

  def edit; end

  def create
    @tag = Tag.find(params[:tag_id])
    @shop.add_tag(@tag)
    redirect_to shop_tags_path(@shop)
  end

  def destroy
    shop_tag = ShopTag.find(params[:id])
    shop = shop_tag.shop
    shop_tag.destroy!
    redirect_to shop_tags_path(shop)
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end
end
