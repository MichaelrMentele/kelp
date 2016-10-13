require 'rails_helper'

describe UsersController do
  describe "GET show" do
    it "sets @user" do
      user = Fabricate(:user)
      get :show, id: user.id
      expect(assigns(:user)).to be_instance_of(User)
    end
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
      it "sets the created user as the logged in user" do
        expect(session[:user_id]).to eq(User.first.id)
      end
      it "redirects to businesses path" do 
        expect(response).to redirect_to businesses_path
      end
    end

    context "with invalid inputs" do
      before { post :create, user: { email: "bob@bob.com" } }
      it "does not create a new user" do 
        expect(User.count).to eq(0)
      end
      it "sets flash errors" do 
        expect(flash[:errors]).to_not be_nil
      end
      it "redirects to the register path" do 
        expect(response).to redirect_to register_path
      end
    end
  end

  describe "GET new" do 
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
end