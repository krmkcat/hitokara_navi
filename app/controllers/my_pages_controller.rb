class MyPagesController < ApplicationController
  def index
    @user = current_user
    reviews_id = @user.reviews.pluck(:id)
    @nices_count = Nice.where(review_id: reviews_id).length
    calculate_reviews_count
  end

  private

  def calculate_reviews_count
    next_goal = if @user.gold?
                  nil
                elsif @user.silver?
                  NUM_OF_REVIEWS_FOR_GOLD
                elsif @user.bronze?
                  NUM_OF_REVIEWS_FOR_SILVER
                else
                  NUM_OF_REVIEWS_FOR_BRONZE
                end
    @reviews_count_for_next_rank = if next_goal.nil?
                                     nil
                                   else
                                     next_goal - @user.reviews.length
                                   end
  end
end
