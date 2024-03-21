class ShopsController < ApplicationController
  skip_before_action :require_login

  def index
    @q = Shop.ransack(params[:q])
    @shops = @q.result(distinct: true)
  end

  def show
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews.order(updated_at: :desc).limit(5)
  end
end
