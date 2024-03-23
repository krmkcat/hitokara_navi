class ShopsController < ApplicationController
  skip_before_action :require_login

  def index
    @search_shops_form = SearchShopsForm.new(search_params)
    @shops = @search_shops_form.search.includes(:tags)
  end

  def show
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews.order(updated_at: :desc).limit(5)
  end

  private

  def search_params
    params[:q]&.permit(:words, :int_average, :eqcust_average, :sofr_average, tag_ids: [])
  end
end
