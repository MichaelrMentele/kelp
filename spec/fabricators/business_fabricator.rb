Fabricator(:business) do
  name { Faker::Lorem.words(2).join(" ") }
  blurb { Faker::Lorem.words(10).join(" ") }
  img_url { "http://placehold.it/125x125" }
  synopsis { Faker::Lorem.paragraph(1) }
  location { Faker::Lorem.paragraph(1) }
  description { Faker::Lorem.paragraph(1) }
end