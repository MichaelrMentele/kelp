require 'rails_helper'

describe RelationshipsController do 
  describe "POST create" do 
    it "redirects to the register page if user is not signed in" do 
      post :create
      expect(response).to redirect_to login_path
    end

    context "user is signed in and follows another user" do 
      let!(:alice) { Fabricate(:user) }
      let!(:bob) { Fabricate(:user) }
      before do 
        set_current_user(alice)
        request.env['HTTP_REFERER'] = user_path(bob)
        post :create, relationship: { user: alice, followable_type: 'User', followable_id: bob.id }
      end

      it "redirects back to the followable resource show page" do 
        expect(response).to redirect_to user_path(bob)
      end

      it "creates a relationship" do 
        expect(Relationship.count).to eq(1)
      end

      it "associates the user and the followable resource through a following relationship" do 
        expect(alice.following_relationships.first.followable).to be_instance_of(User)
      end

      it "sets the flash success message with leaders name" do 
        expect(flash[:success]).to include(bob.username)
      end
    end

    context "user is signed in and follows a business" do 
      let!(:alice) { Fabricate(:user) }
      let!(:yolo_bungee) { Fabricate(:business) }
      before do 
        set_current_user(alice)
        request.env['HTTP_REFERER'] = business_path(yolo_bungee)
        post :create, relationship: { user: alice, followable_type: 'Business', followable_id: yolo_bungee.id }
      end

      it "redirects back to the business show page" do 
        expect(response).to redirect_to business_path(yolo_bungee)
      end

      it "creates a relationship" do 
        expect(Relationship.count).to eq(1)
      end

      it "associates the user and business" do 
        expect(alice.following_relationships.first.followable).to be_instance_of(Business)
      end

      it "sets the flash success message with the business name" do 
        expect(flash[:success]).to include(yolo_bungee.name)
      end
    end
  end
end