class ReviewsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_shop, only: :index
  before_action :set_review, only: %i[edit update destroy]
  before_action :check_reviewd_or_not, only: :new

  def index
    @reviews = @shop.reviews.includes(%i[user profile]).order(updated_at: :desc).page(params[:page])
  end

  def show
    @review = Review.find(params[:id])
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

  def edit; end

  def update
    if @review.update(review_params)
      redirect_to shop_path(@review.shop), success: t('defaults.flash_message.updated', item: Review.model_name.human)
    else
      flash.now[:error] = t('defaults.flash_message.not_updated', item: Review.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    shop = @review.shop
    @review.destroy!
    redirect_to shop_reviews_path(shop), success: t('defaults.flash_message.deleted', item: Review.model_name.human)
  end

  private

  def check_reviewd_or_not
    set_shop
    return unless current_user.reviewed?(@shop)

    redirect_to review_path(current_user.reviews.find_by(shop_id: @shop.id)), error: t('defaults.already_reviewed')
  end

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def review_params
    review_params = params.require(:review).permit(
      :minimal_interaction,
      :equipment_customization,
      :solo_friendly,
      :comment
    )
    if params[:shop_id].present?
      review_params.merge(shop_id: params[:shop_id])
    else
      review_params
    end
  end
end
