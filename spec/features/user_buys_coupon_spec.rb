require 'rails_helper'

feature "user makes purchase" do
  scenario "of business coupon" do
    yolo_bungee = Fabricate(:business)
    coupon = Fabricate(:coupon, business: yolo_bungee, discount_percent: 10, price: 50, description: "10% off our signature jump! Thats a 30$ saving for just 5 dollars! Buy it now and jump to your death!")

    sign_in
    visit businesses_path
    expect(page).to have_content "Sale!"

    click_link yolo_bungee.name
    sleep 4
    expect(page).to have_content "10% off our signature jump!"

    click_button "Pay with Card"
    fill_in "Email", with: "test@ing.com"
    fill_in "Card Number", with: "4242424242424242"

  end
end
