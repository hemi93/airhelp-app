require 'csv'

# Responsible for creating and saving CSV file with application output
class OutputCsvBuilder
  FILE_HEADER = %w(id carrier_code_type carrier_code flight_number date).freeze

  def initialize(data, save_path)
    @data = data
    @save_path = save_path
    raise 'data is required' unless @data
  end

  def save_csv
    ensure_save_path_is_valid
    construct_and_save_csv
  end

  private

  def ensure_save_path_is_valid
    path = @save_path.split('/')
    path_is_nested = path.length > 1
    return unless path_is_nested
    path = path[0..path.length - 2].join('/')
    FileUtils.mkdir_p(path) unless File.exist?(path)
  end

  def construct_and_save_csv
    CSV.open(@save_path, 'w') do |csv|
      push_header(csv)
      push_data(csv)
    end
  end

  def push_header(csv)
    csv << FILE_HEADER
  end

  def push_data(csv)
    @data.each do |flight_data|
      csv << FILE_HEADER.map do |attr_name|
        flight_data.send(attr_name.to_sym)
      end
    end
  end
end
