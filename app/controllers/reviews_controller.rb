class ReviewsController < ApplicationController
  before_filter :require_user

  def create
    @business = Business.find(params[:business_id])
  review = Review.new(review_params.merge!(user: current_user, business: @business))
    if review.save
      flash[:notice] = "Review created!"
      redirect_to :back
    else
      flash.now[:errors] = "I'm sorry, unable to create review."
      render 'businesses/show'
    end
    
  end

  private

  def review_params
    params.require(:review).permit!
  end
end