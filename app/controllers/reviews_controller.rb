class ReviewsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_shop, only: %i[index new]

  def index
    @reviews = @shop.reviews.includes(%i[user profile])
  end

  def show
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to shop_path(id: params[:shop_id]), success: t('.success')
    else
      flash.now[:error] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def review_params
    params.require(:review).permit(
      :shop_id,
      :minimal_interaction,
      :equipment_customization,
      :solo_friendly,
      :comment
    )
    .merge(shop_id: params[:shop_id])
  end
end
