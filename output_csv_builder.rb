require 'csv'

class OutputCsvBuilder
  ATRRIBUTE_NAMES =  ['id', 'carrier_code_type', 'carrier_code', 'flight_number', 'date']

  def initialize(data, save_path)
    @data = data
    @save_path = save_path
    raise 'data is required' unless @data
  end

  def build_csv
    CSV.open(@save_path, 'w') do |csv|
      csv << ATRRIBUTE_NAMES
      @data.each do |flight_data|
        puts flight_data.inspect
        csv << ATRRIBUTE_NAMES.map do |attr_name|
          flight_data.send(attr_name.to_sym)
        end
      end
    end
  end
end
