require './exceptions.rb'
require './carrier_code_classifier.rb'
require './flight_data_record.rb'

class FlightsDataProcessor
  attr_reader :errors_rows

  def initialize(input_data)
    @input_data = input_data
    @output_records = []
    @errors_rows = []
  end

  def process
    @input_data.each_with_index do |row, index|
      next if index.zero?
      begin
        flight_data_record = output_row(row)
      rescue UnknownCarrierCodeType, InvalidParsedDateError, MissingRequiredAttributeValueErrror => error
        @errors_rows << error_row(row, error)
      else
        @output_records << flight_data_record
      end
    end
    @output_records
  end

  def data_container_errors?
    @errors_rows.any?
  end

  private

  def output_row(row)
    id, carrier_code, flight_number, flight_date_text = row
    validate_row(row)
    carrier_code_type = CarrierCodeClassifier.classify_carrier_code(carrier_code)
    date = parse_flight_date(flight_date_text)
    FlightDataRecord.new(id, carrier_code, carrier_code_type, flight_number, date)
  end

  def error_row(row, error)
    id, carrier_code, flight_number, flight_date_text = row
    [id, carrier_code, flight_number, flight_date_text, error.message]
  end

  def parse_flight_date(date_string)
    Date.parse(date_string, '%Y-%m-%d')
  rescue ArgumentError
    raise InvalidParsedDateError, date_string
  end

  def validate_row(row)
    raise MissingRequiredAttributeValueErrror if row.any?(&:nil?)
  end
end
