class ReviewsController < ApplicationController
  def index
  end

  def new
    @shop = Shop.find(params[:shop_id])
    @review = Review.new
  end

  def create
    @shop = Shop.find(params[:shop_id])
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to shop_path(@shop), success: t('.success')
    else
      flash.now[:error] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  private

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
