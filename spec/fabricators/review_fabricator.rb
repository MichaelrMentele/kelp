Fabricator(:review) do 
  rating { [1,2,3,4,5].sample }
  description { Faker::Lorem.paragraph(1) }
end