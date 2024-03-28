require 'net/http'
require 'uri'
require 'json'
require 'csv'

namespace :shop_data do
  desc '店舗情報を取得'
  task get_data: :environment do
    # APIのエンドポイントとAPIキー
    uri = URI.parse('https://places.googleapis.com/v1/places:searchText')
    api_key = ENV['GOOGLE_API_KEY']

    # リクエストボディとヘッダー
    text_query = 'カラオケJOYJOY 新瑞橋店 愛知県'
    request_body = {
      "textQuery" => text_query
    }.to_json

    # Net::HTTPを使ってPOSTリクエストを作成
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, {
      'Content-Type' => 'application/json',
      'X-Goog-Api-Key' => api_key,
      'X-Goog-FieldMask' => 'places.id'
    })
    request.body = request_body

    # リクエストを送信してレスポンスを取得
    response = http.request(request)

    # JSONレスポンスをハッシュにパース
    result = JSON.parse(response.body)

    shops = result['places']
    id_list = []
    shops.each do |shop|
      id_list << shop['id']
    end

    shop_list = []
    id_list.each do |id|
      detail_fields = 'id,name,displayName,formattedAddress,shortFormattedAddress,addressComponents,nationalPhoneNumber,websiteUri,googleMapsUri,regularOpeningHours,location'
      detail_uri = URI.parse("https://places.googleapis.com/v1/places/#{id}?fields=#{detail_fields}&key=#{api_key}&languageCode=ja&regionCode=JP")
      json = Net::HTTP.get(detail_uri)
      detail_result = JSON.parse(json)
      shop_list << detail_result
    end

    bom = "\xEF\xBB\xBF"
    csv_index = %w[google_places_id google_places_name name full_address prefecture short_address phone_number url google_maps_url mon_opening_hours tue_opening_hours wed_opening_hours thu_opening_hours fri_opening_hours sat_opening_hours sun_opening_hours latitude longitude]

    shop_list_for_csv = shop_list.map do |shop|
      [shop['id'],
       shop['name'],
       shop['displayName']['text'],
       shop['formattedAddress'],
       shop['addressComponents'].find { |i| i['types'].include?('administrative_area_level_1') }['longText'],
       shop['shortFormattedAddress'],
       shop['nationalPhoneNumber'],
       shop['websiteUri'],
       shop['googleMapsUri'],
       shop['regularOpeningHours']['weekdayDescriptions'][0],
       shop['regularOpeningHours']['weekdayDescriptions'][1],
       shop['regularOpeningHours']['weekdayDescriptions'][2],
       shop['regularOpeningHours']['weekdayDescriptions'][3],
       shop['regularOpeningHours']['weekdayDescriptions'][4],
       shop['regularOpeningHours']['weekdayDescriptions'][5],
       shop['regularOpeningHours']['weekdayDescriptions'][6],
       shop['location']['latitude'].to_f.round(6),
       shop['location']['longitude'].to_f.round(6)]
    end

    File.open("#{Rails.root.join('csv_files')}/shop_data.csv", 'w') do |file|
      file.print(bom)
      file.puts(csv_index.to_csv)
      shop_list_for_csv.each do |shop|
        file.puts(shop.to_csv)
      end
    end
  end
end
