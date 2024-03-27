require 'net/http'
require 'uri'
require 'json'

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

    shop_data = { shops: shop_list }

    # JSONをファイルに保存
    # ハッシュに変換せず直接出力する場合はpretty_generateは不要
    File.open("#{Rails.root.join('csv_files')}/shop_details.json", 'w') do |f|
      f.write(JSON.pretty_generate(shop_data))
    end
  end
end
