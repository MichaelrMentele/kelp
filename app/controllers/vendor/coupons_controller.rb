class Vendor::CouponsController < VendorsController
  def create
    @coupon = Coupon.new(coupon_params.merge!(business_id: params[:business_id]))
    @business = Business.find(params[:business_id])
    if @coupon.save
      flash[:success] = "Coupon created! Edit to activate for sale."
      redirect_to :back
    else
      flash[:danger] = "Missing coupon information."
      @coupon.price = to_dollars(@coupon.price)
      redirect_to edit_vendor_business_path(@business)
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
    params['coupon']['price'] = to_cents(params['coupon']['price'])
    params.require(:coupon).permit(:discount_percent, :price, :description, :for_sale)
  end

  def to_cents(dollars)
    dollars.to_i * 100
  end

  def to_dollars(cents)
    cents.to_i / 100
  end
end