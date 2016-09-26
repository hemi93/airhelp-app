class FileNotFoundException < StandardError
  def message
    'file was not found'
  end
end

class InvalidCSVFileError < StandardError
  def message
    'provided csv file is invalid'
  end
end

class UnknownCarrierCodeType < StandardError
  def initialize(code)
    @code = code
  end

  def message
    "#{@code} does not match any known carrier code format"
  end
end

class MissingRequiredAttributeValueErrror < StandardError
  def message
    'missing required attribute value'
  end
end

class NotUniqueICAOCarrierCodeError < StandardError
end

class InvalidParsedDateError < StandardError
  def initialize(date_string)
    @date_string = date_string
  end

  def message
    "#{@date_string} is not a valid parsable date"
  end
end
