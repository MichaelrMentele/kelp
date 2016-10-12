require 'rails_helper'

describe SessionsController do
  describe "GET new" do 
    it "redirects to home if user is already signed in"
    it "renders new if no current user"
  end

  describe "GET create" do 
    context "with valid credentials" do 
      it "sets a user id in the session"
      it "redirects to businesses path"
      it "sets the notice"
    end

    context "with invalid credentials" do
      it "does NOT set a user id in the session"
      it "renders the new template"
      it "sets the flass errors"
    end
  end

  describe "POST delete" do
    it "clears the sessions"
    it "redirects to the login path"
    it "sets the notice"
  end
end