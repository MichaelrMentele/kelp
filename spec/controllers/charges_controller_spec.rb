require 'rails_helper'

describe ChargesController do 
  let(:customer) { double(:customer, customer_token: 'abcdefg', id: 1) }
  let(:yolo_bungee) { Fabricate(:business)}

  context "Valid customer and charge" do 
    let(:charge) { double(:charge) }
    let!(:alice) { Fabricate(:user) }
    let!(:yolo_bungee) { Fabricate(:business) }
    let!(:coupon) { Fabricate(:coupon, business: yolo_bungee) }

    before do 
      set_current_user(alice)

      expect(Stripe::Customer).to receive(:create) { customer }
      expect(Stripe::Charge).to receive(:create) { charge }

      request.env['HTTP_REFERER'] = businesses_path(yolo_bungee.id)
      post :create, { coupon_id: coupon.id, stripeToken: 'abcdefg', amount: "500", stripeEmail: "test@ing.com"}
    end

    it "adds the coupon to the current user" do 
      expect(alice.coupons.count).to eq(1)
    end

    it "sets flash success message" do 
      expect(flash[:success]).to be_present
    end

    it "redirects back to the business show page" do 
      expect(response).to redirect_to businesses_path(yolo_bungee.id)
    end
  end

  context "Invalid charge" do 
    before do 
      expect(Stripe::Charge).to receive(:create).with(Exception)
      post :create, { coupon_id: coupon.id, stripeToken: 'abcdefg', amount: "adsfa", stripeEmail: "test@ing.com"}
    end

    it "sets the flash error message" do 
      expect(flash[:danger]).to be_present
    end

    it "renders the business show page" do 
      expect(response).to render_template 'businesses/show'
    end
  end
end