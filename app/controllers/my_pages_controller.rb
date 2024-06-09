class MyPagesController < ApplicationController
  def index
    @user = current_user
    reviews_id = @user.reviews.pluck(:id)
    @nices_count = Nice.where(review_id: reviews_id).length
  end
end
