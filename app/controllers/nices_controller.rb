class NicesController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    current_user.nice(@review)
  end

  def destroy
    @review = current_user.nices.find(params[:id]).review
    current_user.unnice(@review)
  end
end
