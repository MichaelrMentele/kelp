require 'rails_helper'

describe ReviewsController do
  describe "POST create" do 
    let!(:business) { Fabricate(:business) }
    before do
      request.env["HTTP_REFERER"] = business_path(business)
    end

    context "auth'd user" do 
      before do 
        session[:user_id] = Fabricate(:user).id 
      end

      context "with valid inputs" do
        before { post :create, review: Fabricate.attributes_for(:review), business_id: business.id }
        it "creates a new review" do
          expect(Review.count).to eq(1)
        end
        it "associates the review with the current_user" do
          expect(User.first.reviews.count).to eq(1)
        end
        it "associates the review with the correct business" do
          expect(business.reviews.count).to eq(1)
        end
        it "notifies the user" do
          expect(flash[:notice]).not_to be_nil
        end
        it "redirects to the show page for that business" do
          expect(response).to redirect_to business_path(business)
        end
      end

      context "with invalid inputs" do
        before { post :create, review: { description: "blah" }, business_id: business.id }
        it "does not create a new review" do
          expect(Review.count).to eq(0)
        end
        it "sets the flash error message" do 
          expect(flash[:errors]).not_to be_nil
        end
        it "redirects to the show page for that business" do
          expect(response).to redirect_to business_path(business)
        end
      end
    end

    context "unauth'd user" do 
      it "redirects to login path" do 
        post :create, business_id: 1
        expect(response).to redirect_to login_path
      end
    end
  end
end