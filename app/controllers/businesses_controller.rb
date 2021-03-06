class BusinessesController < ApplicationController

  def index
    if params[:sales] == "true"
      @businesses = Business.active_sale_all
    else
      @businesses = Business.all
    end
  end 

  def new
    @business = Business.new
  end

  def create
    business = Business.new(business_params.merge!(img_url: "http://placehold.it/175x175"))
    if business.save
      flash[:success] = "Business created!"
      redirect_to business_path(business)
    else
      flash.now[:danger] = "Invalid inputs."
      render 'businesses/new'
    end
  end

  def show
    @business = Business.find(params[:id])
    @review = Review.new
  end

  private

  def business_params
    params.require(:business).permit!
  end

end