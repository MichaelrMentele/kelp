Fabricator(:user) do
  email { Faker::Internet.email }
  password 'password'
  username { Faker::Name.name }
  img_url { "http://placehold.it/175x175" }
  about { Faker::Lorem.paragraph }
end