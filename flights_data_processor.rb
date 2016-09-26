require './exceptions.rb'
require './carrier_code_parser.rb'
require './flight_data_record.rb'

class FlightsDataProcessor
  def initialize(input_data)
    @input_data = input_data
    @output_records = []
    @errors_data = []
  end

  def process
    @input_data.each_with_index do |row, index|
      next if index.zero?
      begin
        flight_data_record = output_row(row)
      rescue UnknownCarrierCodeType, InvalidParsedDateError, MissingRequiredAttributeValueErrror => error
        @errors_data << error_row(row, error)
      else
        @output_records << flight_data_record
      end
    end
    @output_records
  end

  private

  def output_row(row)
    id, carrier_code, flight_number, flight_date_text = row
    validate_row(row)
    carrier_code_type = CarrierCodeParser.carrier_code_type(carrier_code)
    date = parse_flight_date(flight_date_text)
    FlightDataRecord.new(id, carrier_code, carrier_code_type, flight_number, date)
  end

  def error_row(row, error)
    id, carrier_code, flight_number, flight_date_text = row
    [id, carrier_code, flight_number, flight_date_text, error.message]
  end

  def parse_flight_date(date_string)
    Date.parse(date_string, '%Y-%m-%d')
  rescue ArgumentError => e
    raise InvalidParsedDateError, date_string
  end

  def validate_row(row)
    raise MissingRequiredAttributeValueErrror if row.any?(&:nil?)
  end
end
