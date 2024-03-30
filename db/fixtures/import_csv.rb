module Import
  def self.import_read(file_name)
    CSV.open("csv_files/#{file_name}", 'rb:BOM|UTF-8', headers: true) do |csv|
      csv.map { |line| line.to_h.transform_keys!(&:to_sym) }
    end
  end
end
