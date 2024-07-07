class ShopsController < ApplicationController
  skip_before_action :require_login

  def index
    if search_shops_params.blank?
      redirect_to shop_locations_path
    else
      search_shops
      respond_to do |format|
        format.html
        format.json { render json: @all_shops }
      end
    end
  end

  def show
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews.order(updated_at: :desc).limit(5)
  end

  private

  def search_shops
    @search_shops_params = search_shops_params
    @sort_shops_params = sort_shops_params
    @search_shops_form = SearchShopsForm.new(@search_shops_params)
    @all_shops = @search_shops_form.search
    @all_shops_json = @all_shops.to_json
    @shops = sort_shops(@all_shops).includes(:tags, :favorites).page(params[:page])
    set_center_of_map
  end

  def set_center_of_map
    if @search_shops_params[:latitude].present?
      @center_lat = @search_shops_params[:latitude]
      @center_lng = @search_shops_params[:longitude]
    else
      @center_lat = @all_shops.first.latitude
      @center_lng = @all_shops.first.longitude
    end
    @zoom = if @search_shops_params[:latitude].present?
              13
            elsif @search_shops_params[:area_id].present?
              12
            else
              9
            end
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
    when 'distance'
      relation.sort_by_distance
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
