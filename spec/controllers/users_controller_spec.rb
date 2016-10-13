require 'rails_helper'

describe UsersController do
  describe "GET show" do 
    it "sets @reviews" 
  end

  describe "POST create" do
    context "with valid inputs" do
      before { post :create, user: Fabricate.attributes_for(:user) }
      it "creates a new user" do 
        expect(User.count).to eq(1)
      end
      it "sets flash log in notice" do 
        expect(flash[:notice]).to_not be_nil
      end
      it "sets the created user as the logged in user"
      it "redirects to businesses path"
    end

    context "with invalid inputs" do
      it "does not create a new user"
      it "sets flash errors"
      it "redirects to the register path"
    end
  end

  describe "GET new" do 
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
end