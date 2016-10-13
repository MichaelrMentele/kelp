def sign_in(user=nil)
  user = user || Fabricate(:user)
  visit("/login")
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign In"
end

def register(user=nil)
  visit("/register")
  fill_in "Email Address", with: Faker::Internet.email
  fill_in "Password", with: "password"
  fill_in "Full Name", with: Faker::Name.name
  click_button "Sign Up"
end