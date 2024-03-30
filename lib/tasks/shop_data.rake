require 'net/http'
require 'uri'
require 'json'
require 'csv'
require_relative 'helpers'

namespace :shop_data do
  desc '店舗情報を取得しCSVファイルとしてエクスポート'
  task get_data: :environment do
    if Rails.env.production?
      puts 'このタスクは本番環境では実行できません'
      exit
    end

    uri = URI.parse('https://places.googleapis.com/v1/places:searchText')
    api_key = ENV['GOOGLE_API_KEY']
    text_query = 'カラオケ 愛知県名古屋市天白区'
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    response = http.request(ShopDataHelpers.make_request(uri, api_key, text_query))

    if response.is_a?(Net::HTTPSuccess) == false
      puts "HTTP Request failed (#{response.code})"
    end

    id_list = ShopDataHelpers.make_id_list(JSON.parse(response.body))
    shop_list = ShopDataHelpers.make_shop_list(id_list, api_key)
    shop_list_for_csv = ShopDataHelpers.make_shop_list_for_csv(shop_list)

    bom = "\xEF\xBB\xBF"
    csv_index = %w[google_places_id google_places_name name address_with_zipcode phone_number url google_maps_url mon_opening_hours tue_opening_hours wed_opening_hours thu_opening_hours fri_opening_hours sat_opening_hours sun_opening_hours latitude longitude]

    ShopDataHelpers.export_csv(shop_list_for_csv, bom, csv_index)
    puts 'CSVファイルが正常に出力されました'
  end
end
