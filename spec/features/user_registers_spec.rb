require 'rails_helper'

feature "user registers" do
  scenario "with valid credentials" do
    alice = Fabricate(:user)
    register(alice)
    expect(page).to have_content("Businesses Under the Sea")
  end
end