# Responsible for storing csv row with error information
class ErrorRow
  def initialize(row, error)
    @row = row
    @error = error
  end

  def row
    id, carrier_code, flight_number, flight_date_text = @row
    [id, carrier_code, flight_number, flight_date_text, @error.message]
  end
end
