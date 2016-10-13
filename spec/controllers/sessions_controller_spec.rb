require 'rails_helper'

describe SessionsController do
  describe "GET new" do 
    context "user is signed in" do 
      let(:user) { Fabricate(:user) }
      before do 
        session[:user_id] = user.id
        get :new
      end
      it "redirects to businesses if user is already signed in" do
        expect(response).to redirect_to businesses_path
      end
      it "set flash notice if user is already signed in" do 
        expect(flash[:notice]).not_to be_nil
      end
    end
  end

  describe "POST create" do 
    let(:user) { Fabricate(:user) }
    context "with valid credentials" do 
      before { post :create, { email: user.email, password: user.password } }
      it "sets a user id in the session" do
        expect(session[:user_id]).to eq(user.id)
      end
      it "redirects to businesses path" do 
        expect(response).to redirect_to businesses_path
      end
      it "sets the notice" do 
        expect(flash[:notice]).not_to be_nil
      end
    end

    context "with invalid credentials" do
      before { post :create, { email: user.email } }
      it "does NOT set a user id in the session" do
        expect(session[:user_id]).to be_nil
      end
      it "renders the new template" do
        expect(response).to render_template 'sessions/new'
      end
      it "sets the flash errors" do 
        expect(flash[:errors]).not_to be_nil
      end
    end
  end

  describe "POST destroy" do
    before do 
      session[:user_id] = 1 
      post :destroy
    end
    it "clears the sessions" do 
      expect(session[:user_id]).to be_nil
    end
    it "redirects to the login path" do 
      expect(response).to redirect_to businesses_path
    end
    it "sets the notice" do
      expect(flash[:notice]).not_to be_nil
    end
  end
end