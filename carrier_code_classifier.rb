require './iata_carrier_code_validator.rb'
require './icao_carrier_code_validator.rb'

class CarrierCodeClassifier
  def self.classify_carrier_code(code)
    if IataCarrierCodeValidator.valid?(code)
      :iata
    elsif IcaoCarrierCodeValidator.valid?(code)
      :icao
    else
      raise UnknownCarrierCodeType, code
    end
  end
end
