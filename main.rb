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
    execute
  rescue Interrupt
    abort_with_msg 'Interrupted'
  rescue FileNotFoundException
    abort_with_msg 'Input file was not found under specified path. Aborting!'
  rescue UserProvidedInvalidFilenameError
    abort_with_msg 'Provided invalid filename. Aborting!'
  rescue InvalidCSVFileError
    abort_with_msg 'Provided input CSV file is malformed. Aborting!'
  end

  def fetch_user_options
    @input_file_path, @output_file_path = CmdLineOptionParser.new.options
  end

  def execute
    fetch_user_options
    if OutputFileAccessValidator.new(@output_file_path).access_granted?
      perform_data_processing
    else
      puts 'Cancelled!'
      abort
    end
  end

  def perform_data_processing
    csv_data = CsvLoader.new(@input_file_path).load_data
    processor = FlightsDataProcessor.new(csv_data)
    output_data = processor.output
    save_results(output_data, processor.errors_rows)
    puts "Success. Data saved to: #{@output_file_path}"
  end

  def save_results(output_data, errors_data = nil)
    OutputCsvBuilder.new(output_data, @output_file_path).save_csv
    ErrorsCsvBuilder.new(errors_data).save_csv if errors_data
  end

  def abort_with_msg(message)
    puts message
    abort
  end
end

Main.new
