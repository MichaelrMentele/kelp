require 'rails_helper'

describe UsersController do
  describe "GET show" do 
    it "sets @reviews"
  end

  describe "POST create" do
    context "with valid inputs" do
      it "creates a new user"
      it "sets flash log in notice"
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
    it "sets @user"
  end
end