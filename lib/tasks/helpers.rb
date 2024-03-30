module ShopDataHelpers
  def self.make_request(uri, api_key, text_query)
    request_body = { 'textQuery' => text_query }.to_json
    Net::HTTP::Post.new(uri.request_uri, {
      'Content-Type' => 'application/json',
      'X-Goog-Api-Key' => api_key,
      'X-Goog-FieldMask' => 'places.id'
    }).tap { |req| req.body = request_body }
  end

  def self.make_id_list(result)
    result['places'].map { |shop| shop['id'] }
  end

  def self.make_shop_list(id_list, api_key)
    fields = 'id,name,displayName,formattedAddress,shortFormattedAddress,addressComponents,nationalPhoneNumber,websiteUri,googleMapsUri,regularOpeningHours,location'
    id_list.map do |id|
      uri = URI.parse("https://places.googleapis.com/v1/places/#{id}?fields=#{fields}&key=#{api_key}&languageCode=ja&regionCode=JP")
      JSON.parse(Net::HTTP.get(uri))
    end
  end

  def self.make_shop_list_for_csv(shop_list)
    shop_list.map do |shop|
      [
        shop['id'],
        shop['name'],
        shop.dig('displayName', 'text'),
        shop['formattedAddress'],
        shop['nationalPhoneNumber'],
        shop['websiteUri'],
        shop['googleMapsUri'],
        format_weekday_descriptions(shop),
        format_locations(shop.dig('location', 'latitude')),
        format_locations(shop.dig('location', 'longitude'))
      ]
    end
  end

  def self.export_csv(shop_list_for_csv, bom, csv_index)
    File.open("#{Rails.root.join('csv_files')}/shop_data.csv", 'w') do |f|
      f.print(bom)
      f.puts(csv_index.to_csv)
      shop_list_for_csv.each do |shop|
        f.puts(shop.to_csv)
      end
    end
  end

  def self.format_locations(value)
    value.to_f.round(6) if value.present?
  end

  def self.format_weekday_descriptions(shop)
    shop.dig('regularOpeningHours', 'weekdayDescriptions')&.join('\n')
  end
end
