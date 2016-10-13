class ReviewsController < ApplicationController
  before_filter :require_user

  def create
    business = Business.find(params[:business_id])
    review = Review.new(review_params.merge!(user: current_user, business: business))
    if review.save
      flash[:notice] = "Review created!"
    else
      flash[:errors] = "I'm sorry, unable to create review."
    end
    redirect_to :back
  end

  private

  def review_params
    params.require(:review).permit!
  end
end