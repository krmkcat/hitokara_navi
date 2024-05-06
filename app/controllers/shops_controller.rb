class ShopsController < ApplicationController
  skip_before_action :require_login

  def index
    if search_shops_params.blank?
      redirect_to shop_locations_path
    else
      search_shops
    end
  end

  def show
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews.order(updated_at: :desc).limit(5)
  end

  private

  def search_shops
    @search_shops_params = search_shops_params
    @search_shops_form = SearchShopsForm.new(@search_shops_params)
    @all_shops = @search_shops_form.search
    @shops = sort_shops(@all_shops).includes(:tags).page(params[:page])
  end

  def sort_shops(relation)
    return relation if sort_shops_params.blank?

    case sort_shops_params[:key]
    when 'int'
      relation.sort_by_int
    when 'eqcust'
      relation.sort_by_eqcust
    when 'sofr'
      relation.sort_by_sofr
    else
      relation.sort_by_id
    end
  end

  def sort_shops_params
    params[:sort]&.permit(:key)
  end

  def search_shops_params
    params[:q]&.permit(:words, :area_id, :prefecture_id, :int_average, :eqcust_average, :sofr_average, :latitude, :longitude, tag_ids: [])
  end
end
