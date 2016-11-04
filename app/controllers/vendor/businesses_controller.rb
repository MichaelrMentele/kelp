class Vendor::BusinessesController < VendorsController
  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params.merge!(owner_id: current_user.id, img_url: "http://placehold.it/175x175"))
    if @business.save
      flash[:success] = "Business created!"
      redirect_to business_path(@business)
    else
      flash.now[:danger] = "Invalid inputs."
      render :new
    end
  end

  def edit
    @business = Business.find(params[:id])
    @coupon = Coupon.new
  end

  def update
    @business = Business.find(params[:id])
    @coupon = Coupon.new
    if @business.update_attributes(business_params)
      flash[:success] = "Changes have been saved."
      redirect_to edit_vendor_business_path(current_user)
    else
      flash.now[:danger]
      render :edit
    end
  end

  private

  def business_params
    params.require(:business).permit!
  end
end