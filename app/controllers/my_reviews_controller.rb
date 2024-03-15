class MyReviewsController < ApplicationController
  def index
    @reviews = current_user.reviews.includes(:shop)
  end
end
