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
end