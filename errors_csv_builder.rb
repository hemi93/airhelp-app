require 'csv'

# Responsible for saving CSV file with processing errors
class ErrorsCsvBuilder
  OUTPUT_FILE_PATH = 'error.csv'.freeze
  FILE_HEADER = %w(id carrier_code flight_number date error_reason).freeze

  def initialize(data)
    @data = data
    raise 'data is required' unless @data
  end

  def save_csv
    CSV.open(OUTPUT_FILE_PATH, 'w') do |csv|
      push_header(csv)
      push_data(csv)
    end
  end

  private

  def push_header(csv)
    csv << FILE_HEADER
  end

  def push_data(csv)
    @data.each do |error_row|
      csv << error_row
    end
  end
end
