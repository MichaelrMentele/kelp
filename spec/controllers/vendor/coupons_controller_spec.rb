require 'rails_helper'

describe Vendor::CouponsController do 
  describe "PATCH update" do 
    let!(:alice) { Fabricate(:user, vendor: true) }
    let!(:yolo_bungee) { Fabricate(:business, owner: alice) }
    let!(:coupon) { Fabricate(:coupon, business: yolo_bungee, for_sale: false) }
    before { set_current_user(alice) }

    context "with valid changes" do
      before do 
        patch(:update, 
          business_id: yolo_bungee.id, 
          id: coupon.id, 
          coupon: { 
            discount_percent: coupon.discount_percent, 
            price: coupon.price, 
            description: coupon.description,
            for_sale: true
          }
        )
      end

      it "sets @coupon" do 
        expect(assigns(:coupon)).to be_instance_of(Coupon)
      end

      it "updates @coupon" do 
        expect(Coupon.first.for_sale).to eq(true)
      end

      it "redirects to the business edit page" do 
        expect(response).to redirect_to edit_vendor_business_path(yolo_bungee)
      end

      it "sets a flash success message" do 
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid changes" do
      before do 
        patch(:update, 
          business_id: yolo_bungee.id, 
          id: coupon.id, 
          coupon: { 
            discount_percent: coupon.discount_percent, 
            price: nil, 
            description: "",
            for_sale: true
          }
        )
      end 

      it "does not update @business" do 
        expect(coupon.for_sale).to eq(false)
      end

      it "renders the edit page" do 
        expect(response).to render_template 'vendor/coupons/edit'
      end
    end
  end

  describe "GET edit" do 
    context "the owner edits their coupon" do 
      let!(:alice) { Fabricate(:user, vendor: true) }
      let!(:yolo_bungee) { Fabricate(:business, owner: alice) }
      let!(:coupon) { Fabricate(:coupon, business: yolo_bungee) }

      before do 
        set_current_user(alice)
        get :edit, business_id: yolo_bungee.id, id: coupon.id
      end

      it "sets @coupon" do 
        expect(assigns(:coupon)).to be_instance_of(Coupon)
      end

      it "sets @business" do 
        expect(assigns(:business)).to be_instance_of(Business)
      end
    end

    context "NOT the owner tries to edit a coupon" do 
      let!(:alice) { Fabricate(:user) }
      let!(:bob) { Fabricate(:user) }
      let!(:yolo_bungee) { Fabricate(:business, owner: alice) }
      let!(:coupon) { Fabricate(:coupon, business: yolo_bungee) }

      before do
        set_current_user(bob)
        get :edit, business_id: yolo_bungee.id, id: coupon.id 
      end

      it "redirects if not the owner" do 
        expect(response).to redirect_to businesses_path
      end

      it "sets flash warning if not the owner" do 
        expect(flash[:warning]).to be_present
      end
    end
  end

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