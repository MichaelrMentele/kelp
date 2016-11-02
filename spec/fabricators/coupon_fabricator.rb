Fabricator(:coupon) do 
  for_sale { false }
  discount_percent { 10 }
  price { Faker::Number.number(1) }
  description { Faker::Lorem.paragraph(1) }
end
