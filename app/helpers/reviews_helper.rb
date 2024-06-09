module ReviewsHelper
  def nices_count(review)
    return if review.nices.blank?

    review.nices.length
  end
end