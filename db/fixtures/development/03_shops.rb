number_of_areas = Area.count

20.times do |n|
  Shop.seed do |s|
    s.id = n + 1
    s.area_id = rand(1..number_of_areas)
    s.name = Faker::Restaurant.name.unique
    s.address = Faker::Address.full_address.unique
    s.phone_number = Faker::PhoneNumber.phone_number
    s.url = Faker::Internet.url.unique
    s.opening_hours = '11:00〜24:00'
    s.latitude = Faker::Address.latitude
    s.longitude = Faker::Address.longitude
  end
end
