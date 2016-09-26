require 'csv'

class OutputCsvBuilder
  ATRRIBUTE_NAMES = %w(id carrier_code_type carrier_code flight_number date).freeze

  def initialize(data, save_path)
    @data = data
    @save_path = save_path
    raise 'data is required' unless @data
  end

  def build_and_save_csv
    ensure_save_path_is_valid
    CSV.open(@save_path, 'w') do |csv|
      csv << ATRRIBUTE_NAMES
      @data.each do |flight_data|
        csv << ATRRIBUTE_NAMES.map do |attr_name|
          flight_data.send(attr_name.to_sym)
        end
      end
    end
  end

  private

  def ensure_save_path_is_valid
    path = @save_path.split('/')
    path = path[0..path.length - 2].join('/')
    FileUtils.mkdir_p(path) unless File.exist?(path)
  end
end
