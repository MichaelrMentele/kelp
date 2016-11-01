require 'rails_helper'

describe ChargesController do 
  let(:customer) { double(:customer, customer_token: 'abcdefg', id: 1) }
  let(:yolo_bungee) { Fabricate(:business)}

  context "Valid customer and charge" do 
    let(:charge) { double(:charge) }
    before do 
      expect(Stripe::Customer).to receive(:create) { customer }
      expect(Stripe::Charge).to receive(:create) { charge }
      request.env['HTTP_REFERER'] = businesses_path(yolo_bungee.id)
      post :create, { stripeToken: 'abcdefg', amount: "500", stripeEmail: "test@ing.com"}
    end
    it "sets flash success message" do 
      expect(flash[:success]).to be_present
    end

    it "redirects back to the business show page" do 
      expect(response).to redirect_to businesses_path(yolo_bungee.id)
    end
  end

  context "Invalid charge" do 
    it "sets the flash error message"

    it "renders the business show page"
  end
end