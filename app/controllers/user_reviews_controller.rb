class UserReviewsController < ApplicationController
  def index
    @reviews = current_user.reviews.includes(:shop).order(updated_at: :desc).page(params[:page])
  end
end
