#!/usr/bin/ruby
require './cmd_line_option_parser.rb'
require './csv_loader.rb'
require './exceptions.rb'
require './flights_data_processor.rb'
require './output_csv_builder.rb'
require './errors_csv_builder.rb'
require './output_file_access_validator.rb'
require 'fileutils'

# Entrypoint of appliaction
class Main
  def initialize
    run
  end

  private

  def run
    fetch_user_options
    if OutputFileAccessValidator.new(@output_file_path).access_granted?
      perform
    else
      puts 'Cancelled!'
      abort
    end
  rescue Interrupt
    puts 'Interrupted'
  rescue FileNotFoundException
    puts 'Input file was not found under specified path. Aborting!'
    abort
  rescue UserProvidedInvalidFilenameError
    puts 'Provided invalid filename. Aborting!'
    abort
  rescue InvalidCSVFileError
    puts 'Provided input CSV file is malformed. Aborting!'
    abort
  end

  def fetch_user_options
    @input_file_path, @output_file_path = CmdLineOptionParser.new.options
  end

  def perform
    csv_data = CsvLoader.new(@input_file_path).load_data
    processor = FlightsDataProcessor.new(csv_data)
    output_data = processor.process
    OutputCsvBuilder.new(output_data, @output_file_path).save_csv
    ErrorsCsvBuilder.new(processor.errors_rows).save_csv if processor.errors?
    puts "Success. Data saved to: #{@output_file_path}"
  end
end

Main.new
