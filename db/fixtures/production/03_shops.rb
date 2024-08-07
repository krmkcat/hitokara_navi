require "#{Rails.root}/db/fixtures/import_csv"

shops = Import.import_read('shops_production.csv')

shops.each do |shop|
  Shop.seed do |s|
    s.id = shop[:id]
    s.area_id = shop[:area_id]
    s.name = shop[:name]
    s.address = shop[:address]
    s.phone_number = shop[:phone_number]
    s.url = shop[:url]
    s.opening_hours = Import.formatted_opening_hours(shop)
    s.latitude = shop[:latitude]
    s.longitude = shop[:longitude]
  end
end
