require 'rails_helper'

describe Vendor::CouponsController do 
  describe "POST create" do 
    context "valid inputs" do 
      let!(:alice) { Fabricate(:user, vendor: true) }
      let!(:yolo_bungee) { Fabricate(:business) }
      before do 
        set_current_user(alice)
        request.env['HTTP_REFERER'] = edit_vendor_business_path(yolo_bungee)
        post :create, business_id: yolo_bungee.id, coupon: { discount_percent: 10, price: 5, description: "Stuff." }
      end

      it "creates a coupon" do 
        expect(Coupon.count).to eq(1)
      end

      it "sets the flash success message" do 
        expect(flash[:success]).to be_present
      end

      it "redirects back to the business edit page" do 
        expect(response).to redirect_to edit_vendor_business_path(yolo_bungee)
      end
    end

    context "invalid inputs" do 
      let!(:alice) { Fabricate(:user, vendor: true) }
      let!(:yolo_bungee) { Fabricate(:business) }
      before do 
        set_current_user(alice)
        post :create, coupon: { description: "Stuff." }, business_id: yolo_bungee.id
      end

      it "does not create a coupon" do 
        expect(Coupon.count).to eq(0)
      end

      it "sets the flash danger message" do 
        expect(flash[:danger]).to be_present
      end

      it "renders the business edit page" do 
        expect(response).to render_template 'vendor/businesses/edit'
      end
    end
  end
end