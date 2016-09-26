require 'fileutils'
require 'csv'
require './exceptions.rb'

class CsvLoader
  def initialize(input_file_path)
    @input_file_path = input_file_path
  end

  def load_data
    raise FileNotFoundException unless File.exist?(@input_file_path)
    CSV.read(@input_file_path)
  rescue CSV::MalformedCSVError
    raise InvalidCSVFileError
  end
end
