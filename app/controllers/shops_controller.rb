class ShopsController < ApplicationController
  skip_before_action :require_login

  def index
    @search_shops_form = SearchShopsForm.new(search_params)
    @all_shops = @search_shops_form.search
    @shops = @all_shops.includes(:tags).order(area_id: :asc).page(params[:page])
  end

  def show
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews.order(updated_at: :desc).limit(5)
  end

  private

  def search_params
    params[:q]&.permit(:words, :int_average, :eqcust_average, :sofr_average, :area_id, :prefecture_id, tag_ids: [])
  end
end
