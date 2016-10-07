require 'csv'

# Responsible for building and saving CSV file with flights data processing errors
class ErrorsCsvBuilder
  ATRRIBUTE_NAMES = %w(id carrier_code flight_number date error_reason).freeze

  def initialize(data)
    @data = data
    raise 'data is required' unless @data
  end

  def save_csv
    CSV.open('error.csv', 'w') do |csv|
      csv << ATRRIBUTE_NAMES
      @data.each do |error_row|
        csv << error_row
      end
    end
  end
end
