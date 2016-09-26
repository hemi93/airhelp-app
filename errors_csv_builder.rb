require 'csv'
require 'fileutils'

class ErrorsCsvBuilder
  ATRRIBUTE_NAMES = %w(id carrier_code flight_number date).freeze

  def initialize(data)
    @data = data
    raise 'data is required' unless @data
  end

  def build_and_save_csv
    CSV.open('error.csv', 'w') do |csv|
      csv << ATRRIBUTE_NAMES
      @data.each do |error_row|
        csv << error_row
      end
    end
  end
end
