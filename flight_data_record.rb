class FlightDataRecord
  attr_reader :id, :carrier_code, :carrier_code_type, :flight_number, :date

  def initialize(id, carrier_code, carrier_code_type, flight_number, date)
    @id = id
    @carrier_code = carrier_code
    @carrier_code_type = carrier_code_type.to_s.upcase
    @flight_number = flight_number
    @date = date.strftime('%Y-%m-%d')
  end
end
