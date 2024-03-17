class ShopsController < ApplicationController
  skip_before_action :require_login

  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews.order(updated_at: :desc).limit(5)
  end
end
