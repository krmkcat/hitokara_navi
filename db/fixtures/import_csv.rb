require 'csv'

module Import
  def self.import_read(file_name)
    CSV.open(Rails.root.join('db', 'fixtures', 'csv_files', file_name.to_s), 'rb:BOM|UTF-8', headers: true) do |csv|
      csv.map { |line| line.to_h.transform_keys!(&:to_sym) }
    end
  end

  def self.formatted_opening_hours(shop)
    opening_hours_list = [
      shop[:mon_opening_hours],
      shop[:tue_opening_hours],
      shop[:wed_opening_hours],
      shop[:thu_opening_hours],
      shop[:fri_opening_hours],
      shop[:sat_opening_hours],
      shop[:sun_opening_hours],
    ].join("\n")
  end
end
