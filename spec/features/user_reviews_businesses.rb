require "rails_helper"

feature "user can leave reviews" do
  scenario "and sets reviews on multiple businesses" do
    shennanigans = Fabricate(:business)
    pizza_hut = Fabricate(:business)

    sign_in
  end
end
