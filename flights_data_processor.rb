require './exceptions.rb'
require './carrier_code_classifier.rb'
require './flight_data_record.rb'
require './error_row.rb'

# Responsible for creating raw output data with classified carrier codes
class FlightsDataProcessor
  attr_reader :errors_rows

  def initialize(input_data)
    @input_data = input_data
    @output_records = []
    @errors_rows = []
  end

  def output
    @input_data.each_with_index do |row, index|
      next if index.zero?
      process_row(row)
    end
    @output_records
  end

  def errors?
    @errors_rows.any?
  end

  private

  def process_row(row)
    flight_data_record = output_row(row)
  rescue UnknownCarrierCodeType, InvalidParsedDateError,
         MissingRequiredAttributeValueErrror => error
    @errors_rows << ErrorRow.new(row, error).row
  else
    @output_records << flight_data_record
  end

  def output_row(row)
    id, carrier_code, flight_number, flight_date_text = row
    validate_row(row)
    code_type = CarrierCodeClassifier.classify(carrier_code)
    date = parse_flight_date(flight_date_text)
    FlightDataRecord.new(id, carrier_code, code_type, flight_number, date)
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
