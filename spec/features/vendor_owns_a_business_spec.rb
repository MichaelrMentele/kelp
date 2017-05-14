require 'rails_helper'

feature "vendor can own a business" do
  scenario "can create a business" do
    alice = Fabricate(:user, vendor: true)
    sign_in(alice)

    click_link "Add Business"
    sleep 1

    fill_in "Name", with: "Yolo Bungee"
    fill_in "Why do people care?", with: "Best ever!"
    fill_in "What do they do?", with: "Jump off things"
    fill_in "Where are they?", with: "Dallas, Tx"
    fill_in "More Information", with: "Meh..."
    click_button "Submit"
    sleep 1


  end

  scenario "can view and edit their business"
  scenario "can create a coupon"
end
