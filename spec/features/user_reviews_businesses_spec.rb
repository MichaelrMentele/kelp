require "rails_helper"

feature "user can leave reviews" do
  scenario "and sets reviews on multiple businesses" do
    shennanigans = Fabricate(:business)
    pizza_hut = Fabricate(:business)

    sign_in

    ['1', '2'].each do |num|
      visit businesses_path
      show_business(num)
      add_and_validate_reviews
    end
  end
end

def show_business(num)
  click_link(num)
end

def add_and_validate_reviews(review_titles=['Great', 'Bad'])
  review_titles.each do |title|
    fill_in('Review Title', with: title)
    fill_in('Description', with: 'Blah blah')
    click_button('Submit')
    page.has_content?(title)
  end
end