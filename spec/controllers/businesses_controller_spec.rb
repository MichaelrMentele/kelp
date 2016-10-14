require 'rails_helper'

describe BusinessesController do 
  describe "GET index" do 
    it "sets @businesses" do 
      launchschool = Fabricate(:business)
      get :index
      expect(assigns(:businesses)).to match_array([launchschool])
    end
  end

  describe "GET show" do
    it "sets @business" do 
      launchschool = Fabricate(:business)
      get :show, id: launchschool.id
      expect(assigns(:business)).to eq(launchschool)
    end
  end

  describe "GET new" do
    it "sets @business" do 
      get :new
      expect(assigns(:business)).to be_instance_of(Business)
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      let!(:business_attr) { Fabricate.attributes_for(:business) }
      before { post :create, { business: business_attr } }

      it "redirects to the show page" do
        expect(response).to redirect_to business_path(Business.first.id)
      end
      it "creates a new business" do 
        expect(Business.count).to eq(1)
      end
      it "sets the flash notice" do
        expect(flash[:notice]).not_to be_nil
      end
    end
      
    context "with invalid inputs" do
      before { post :create, { business: {name: "test"} } }
      it "redirects to the new page" do
        expect(response).to redirect_to new_business_path
      end
      it "does NOT create a new business" do
        expect(Business.count).to eq(0)
      end
      it "sets the flash error" do
        expect(flash[:errors]).not_to be_nil
      end
    end
  end
end