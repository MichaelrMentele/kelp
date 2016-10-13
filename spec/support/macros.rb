def sign_in(user=nil)
  user = user || Fabricate(:user)
  visit("/login")
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end