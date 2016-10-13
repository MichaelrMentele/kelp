require 'rails_helper'

feature "user signs in" do
  scenario "with valid credentials" do
    alice = Fabricate(:user)
    sign_in(alice)
    expect(page).to have_content("Businesses Under the Sea")
  end
end