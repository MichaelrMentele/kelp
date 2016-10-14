require "rails_helper"

feature "user can leave reviews" do
  scenario "and sets reviews on multiple businesses" do
    shennanigans = Fabricate(:business)
    pizza_hut = Fabricate(:business)

    sign_in

    # visits businesses page
    # clicks on business
    # fills out review form
    # submits review form
    # fills out review form
    # submits review form
    # x each business
  end
end
