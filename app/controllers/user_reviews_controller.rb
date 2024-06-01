class UserReviewsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @reviews = @user.reviews.includes(:shop).order(updated_at: :desc).page(params[:page])
  end
end
