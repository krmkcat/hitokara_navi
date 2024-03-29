require 'net/http'
require 'uri'
require 'json'
require 'csv'

namespace :shop_data do
  def make_request(uri, api_key, text_query)
    request_body = { 'textQuery' => text_query }.to_json
    Net::HTTP::Post.new(uri.request_uri, {
      'Content-Type' => 'application/json',
      'X-Goog-Api-Key' => api_key,
      'X-Goog-FieldMask' => 'places.id'
    }).tap { |req| req.body = request_body }
  end

  def make_id_list(result)
    result['places'].map { |shop| shop['id'] }
  end

  def make_shop_list(id_list, api_key)
    fields = 'id,name,displayName,formattedAddress,shortFormattedAddress,addressComponents,nationalPhoneNumber,websiteUri,googleMapsUri,regularOpeningHours,location'
    id_list.map do |id|
      uri = URI.parse("https://places.googleapis.com/v1/places/#{id}?fields=#{fields}&key=#{api_key}&languageCode=ja&regionCode=JP")
      JSON.parse(Net::HTTP.get(uri))
    end
  end

  def make_shop_list_for_csv(shop_list)
    shop_list.map do |shop|
      [
        shop['id'],
        shop['name'],
        shop.dig('displayName', 'text'),
        shop['formattedAddress'],
        find_address_component(shop, 'administrative_area_level_1'),
        shop['shortFormattedAddress'],
        shop['nationalPhoneNumber'],
        shop['websiteUri'],
        shop['googleMapsUri'],
        format_weekday_descriptions(shop),
        format_locations(shop.dig('location', 'latitude')),
        format_locations(shop.dig('location', 'longitude'))
      ]
    end
  end

  def format_locations(value)
    value.to_f.round(6) if value.present?
  end

  def find_address_component(shop, type)
    shop['addressComponents'].find { |component| component['types'].include?(type) }&.fetch('longText', nil)
  end

  def format_weekday_descriptions(shop)
    shop.dig('regularOpeningHours', 'weekdayDescriptions')&.join('\n')
  end

  def export_csv(shop_list_for_csv, bom, csv_index)
    File.open("#{Rails.root.join('csv_files')}/shop_data.csv", 'w') do |f|
      f.print(bom)
      f.puts(csv_index.to_csv)
      shop_list_for_csv.each do |shop|
        f.puts(shop.to_csv)
      end
    end
  end

  desc '店舗情報を取得'
  task get_data: :environment do
    uri = URI.parse('https://places.googleapis.com/v1/places:searchText')
    api_key = ENV['GOOGLE_API_KEY']
    text_query = 'カラオケ 愛知県名古屋市天白区'
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    response = http.request(make_request(uri, api_key, text_query))

    if response.is_a?(Net::HTTPSuccess) == false
      puts "HTTP Request failed (#{response.code})"
    end

    id_list = make_id_list(JSON.parse(response.body))
    shop_list = make_shop_list(id_list, api_key)
    shop_list_for_csv = make_shop_list_for_csv(shop_list)

    bom = "\xEF\xBB\xBF"
    csv_index = %w[google_places_id google_places_name name full_address prefecture short_address phone_number url google_maps_url opening_hours latitude longitude]

    export_csv(shop_list_for_csv, bom, csv_index)
    puts 'CSVファイルが正常に出力されました'
  end
end
