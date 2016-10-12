require 'rails_helper'

describe ReviewsController do
  describe "POST create" do 
    context "auth'd user" do 
      context "with valid inputs" do
        it "creates a new review"
        it "associates the review with the current_user"
        it "associates the review with the correct business"
        it "redirects to the show page for that business"
      end

      context "with invalid inputs" do
        it "does not create a new review"
        it "sets the flash error message"
        it "redirects to the show page for that business"
      end
    end

    context "unauth'd user" do 
      it "should redirect to login"
    end
  end
end