class Vendor::CouponsController < VendorsController
  def create
    @coupon = Coupon.new(coupon_params.merge!(business_id: params[:business_id]))
    if @coupon.save
      flash[:success] = "Coupon created! These are already for sale."
      redirect_to :back
    else
      flash.now[:danger] = "Missing coupon information."
      @business = Business.find(params[:business_id])
      render '/vendor/businesses/edit'
    end
  end

  def edit
    @coupon = Coupon.find(params[:id])
    @business = @coupon.business
  end

  def update
    @coupon = Coupon.find(params[:id])
    @business = @coupon.business

    if @coupon.update_attributes(coupon_params)
      flash[:success] = "Coupon has been updated."
      redirect_to edit_vendor_business_path(@business)
    else
      render :edit
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:discount_percent, :price, :description, :for_sale)
  end
end