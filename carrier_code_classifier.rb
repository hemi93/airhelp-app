require './iata_carrier_code_validator.rb'
require './icao_carrier_code_validator.rb'

# Responsible for classifying carrier codes
class CarrierCodeClassifier
  def self.classify(code)
    if IataCarrierCodeValidator.valid?(code)
      :iata
    elsif IcaoCarrierCodeValidator.valid?(code)
      :icao
    else
      raise UnknownCarrierCodeType, code
    end
  end
end
