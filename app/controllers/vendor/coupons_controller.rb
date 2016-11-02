class Vendor::CouponsController < VendorsController
  def create
    @coupon = Coupon.new(coupon_params.merge!(business_id: params[:business_id]))
    binding.pry
    if @coupon.save
      flash[:success] = "Coupon created! These are already for sale."
      redirect_to :back
    else
      flash.now[:danger] = "Missing coupon information."
      @business = Business.find(params[:business_id])
      render '/vendor/businesses/edit'
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:discount_percent, :price, :description)
  end
end