class ShopsController < ApplicationController
  skip_before_action :require_login

  def index
    if search_shops_params.blank?
      redirect_to shop_locations_path
    else
      @search_shops_params = search_shops_params
      @search_shops_form = SearchShopsForm.new(@search_shops_params)
      @all_shops = @search_shops_form.search
      @shops = @all_shops.includes(:tags).page(params[:page])
    end
  end

  def show
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews.order(updated_at: :desc).limit(5)
  end

  private

  def search_shops_params
    params[:q]&.permit(:words, :area_id, :prefecture_id, :int_average, :eqcust_average, :sofr_average, :latitude, :longitude, tag_ids: [])
  end
end
