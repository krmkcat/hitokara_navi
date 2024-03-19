number_of_areas = Area.count

20.times do |n|
  Shop.seed do |s|
    s.id = n + 1
    s.area_id = rand(1..number_of_areas)
    s.name = Faker::Restaurant.unique.name
    s.address = Faker::Address.unique.full_address
    s.phone_number = Faker::PhoneNumber.phone_number
    s.url = Faker::Internet.unique.url
    s.opening_hours = '11:00〜24:00'
    s.latitude = Faker::Address.unique.latitude
    s.longitude = Faker::Address.unique.longitude
  end
end
