#!/usr/bin/ruby
require './cmd_line_option_parser.rb'
require './csv_loader.rb'
require './exceptions.rb'
require './flights_data_processor.rb'
require './output_csv_builder.rb'

class Main
  def initialize
    run
  end

  private

  def run
    input_file_path, output_file_path = CmdLineOptionParser.new.user_provided_options
    csv_data = CsvLoader.new(input_file_path).load_data
    output_data = FlightsDataProcessor.new(csv_data).process
    output_csv = OutputCsvBuilder.new(output_data, output_file_path).build_csv
  rescue Interrupt
    puts 'Interrupted'
  rescue FileNotFoundException
    puts 'Input file was not found under specified path. Aborting!'
    abort
  rescue InvalidCSVFileError
    puts 'Provided input CSV file is malformed. Aborting!'
    abort
  else
    puts 'Success'
  end
end

Main.new
