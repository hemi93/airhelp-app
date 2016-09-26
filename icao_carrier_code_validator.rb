class IcaoCarrierCodeValidator
  VALID_CODE_REGEXP = /(^[A-Z]{3}$)/

  def self.valid?(code)
    code =~ VALID_CODE_REGEXP
  end
end
