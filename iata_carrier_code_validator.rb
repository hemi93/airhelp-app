class IataCarrierCodeValidator
  VALID_CODE_REGEXP = /(^[A-Z]{2}(?=\*)$)|(^[A-Z]{2}$)/

  def self.valid?(code)
    code =~ VALID_CODE_REGEXP
  end
end
