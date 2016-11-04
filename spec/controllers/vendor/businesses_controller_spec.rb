require 'rails_helper'

describe Vendor::BusinessesController do
  describe "PATCH update" do 
    context "with valid changes" do
      let!(:yolo_bungee) { Fabricate(:business) }  
      let(:alice) { Fabricate(:user, vendor: true) } 
      before do 
        set_current_user(alice)
        patch :update, id: yolo_bungee.id, business: { name: "bob's burgers", blurb: yolo_bungee.blurb, synopsis: yolo_bungee.synopsis, location: yolo_bungee.location, description: yolo_bungee.description }
      end

      it "sets @business" do 
        expect(assigns(:business)).to be_instance_of(Business)
      end

      it "updates @business" do 
        expect(Business.first.name).to eq("bob's burgers")
      end

      it "redirects to the edit page" do 
        expect(response).to redirect_to edit_vendor_business_path(yolo_bungee)
      end

      it "sets a flash success message" do 
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid changes" do 
      let!(:yolo_bungee) { Fabricate(:business) }  
      let(:alice) { Fabricate(:user, vendor: true) } 
      before do 
        set_current_user(alice)
        patch :update, id: yolo_bungee.id, business: { name: "" }
      end

      it "does not update @business" do 
        expect(Business.first.name).to eq(yolo_bungee.name)
      end

      it "sets a flash error message" do 
        expect(flash.now[:danger]).to be_present
      end

      it "renders the edit page" do 
        expect(response).to render_template 'vendor/businesses/edit'
      end
    end
  end

  describe "POST create" do 
    context "current user is a vendor" do
      let(:alice) { Fabricate(:user, vendor: true) } 
      before do 
        set_current_user(alice)
        post :create, business: { name: "bob's burgers", blurb: "Okay burgers.", synopsis: "We make okay burgers on teh grill", location: "Around", description: "We are a small place that makes bad burgers." }
      end

      it "creates a business" do 
        expect(Business.all.count).to eq(1)
      end

      it "associates the business with the current user" do 
        expect(Business.first.owner).to eq(alice)
      end

      it "sets the flash success method" do 
        expect(flash[:success]).to be_present
      end
    end

    context "current user is NOT a vendor" do
      let(:alice) { Fabricate(:user, vendor: false) } 
      before do 
        set_current_user(alice)
        post :create, business: { name: "bob's burgers", blurb: "Okay burgers.", synopsis: "We make okay burgers on teh grill", location: "Around", description: "We are a small place that makes bad burgers." }
      end

      it "redirects the user to the businesses path" do 
        post :create
        expect(response).to redirect_to businesses_path
      end

      it "it sets the flash warning" do 
        post :create
        expect(flash[:warning]).to be_present
      end
    end
  end

  describe "GET new" do 
    context "current user is a vendor" do 
      let(:alice) { Fabricate(:user, vendor: true) }
      before { set_current_user(alice) }

      it "sets @business" do 
        get :new

        expect(assigns(:business)).to be_present
      end

      it "renders the new business page" do 
        get :new

        expect(response).to render_template "businesses/new"
      end
    end

    context "current user is NOT a vendor" do
      let(:alice) { Fabricate(:user, vendor: false) } 
      before { set_current_user(alice) } 

      it "redirects the user to the businesses path" do 
        get :new
        expect(response).to redirect_to businesses_path
      end

      it "it sets the flash warning" do 
        get :new
        expect(flash[:warning]).to be_present
      end
    end
  end

  describe "GET edit" do 
    context "current user is a vendor and edits their business" do 
      let(:alice) { Fabricate(:user, vendor: true) }
      let(:yolo_bungee) { Fabricate(:business, owner: alice) }
      before do
        set_current_user(alice)
        get :edit, id: yolo_bungee.id
      end

      it "sets @business" do
        expect(assigns(:business)).to be_present
      end

      it "sets @coupon" do 
        expect(assigns(:coupon)).to be_present
      end

      it "renders the edit business page" do 
        expect(response).to render_template "businesses/edit"
      end
    end

    context "current user is NOT a vendor and tries to edit someone elses business" do
      let(:alice) { Fabricate(:user, vendor: false) }
      let(:bob) { Fabricate(:user, vendor: true) }
      let(:yolo_bungee) { Fabricate(:business, owner: bob) }
      before { set_current_user(alice) }

      it "redirects the user to the businesses path" do 
        get :edit, id: yolo_bungee.id
        expect(response).to redirect_to businesses_path
      end

      it "it sets the flash warning" do 
        get :edit, id: yolo_bungee.id
        expect(flash[:warning]).to be_present
      end
    end
  end
end