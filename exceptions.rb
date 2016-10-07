# Thrown when file under specified path was not found
class FileNotFoundException < StandardError
  def message
    'file was not found'
  end
end

# Thrown when loaded CSV is not valid
class InvalidCSVFileError < StandardError
  def message
    'provided csv file is invalid'
  end
end

# Thrown when application found unsupported carrier code in input data
class UnknownCarrierCodeType < StandardError
  def initialize(code)
    @code = code
  end

  def message
    "#{@code} does not match any known carrier code format"
  end
end

# Thrown when there is missing required attribute
class MissingRequiredAttributeValueErrror < StandardError
  def message
    'missing required attribute value'
  end
end

# Thrown when there is invalid date in input data that cannot be parsed
class InvalidParsedDateError < StandardError
  def initialize(date_string)
    @date_string = date_string
  end

  def message
    "#{@date_string} is not a valid parsable date"
  end
end

# Thrown when user provides invalid filename for input or output files
class UserProvidedInvalidFilenameError < StandardError
end
