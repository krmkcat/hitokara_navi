class ShopsController < ApplicationController
  skip_before_action :require_login

  def index
    @shop_locations_form = ShopLocationsForm.new(shop_locations_params)
    @search_shops_form = SearchShopsForm.new(shop_details_params)
    @all_shops = @search_shops_form.search
    @shops = @all_shops.includes(:tags).order(area_id: :asc).page(params[:page])
  end

  def show
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews.order(updated_at: :desc).limit(5)
  end

  private
  def shop_locations_params
    params[:l_q]&.permit(:words, :area_id, :prefecture_id)
  end

  def shop_details_params
    params[:q]&.permit(:words, :int_average, :eqcust_average, :sofr_average, :area_id, :prefecture_id, tag_ids: [])
  end
end
