class ShopsController < ApplicationController
  skip_before_action :require_login

  def index
    @shop_locations_form = ShopLocationsForm.new(shop_locations_params)
    narrowed_down_shops = @shop_locations_form.search
    @shop_details_form = ShopDetailsForm.new(shop_details_params)
    @all_shops = @shop_details_form.search(narrowed_down_shops)
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
    params[:d_q]&.permit(:int_average, :eqcust_average, :sofr_average, tag_ids: [])
  end
end
