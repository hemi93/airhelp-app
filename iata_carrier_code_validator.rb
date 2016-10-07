# Responsible for validating IATA carrier code
class IataCarrierCodeValidator
  VALID_CODE_REGEXP = /((([A-Z]|\d){2}(?=\*)))|(^([A-Z]|\d){2}$)/

  def self.valid?(code)
    code =~ VALID_CODE_REGEXP
  end
end
