#!/usr/bin/ruby
require './cmd_line_option_parser.rb'
require './csv_loader.rb'
require './exceptions.rb'
require './flights_data_processor.rb'
require './output_csv_builder.rb'
require './errors_csv_builder.rb'
require 'fileutils'

class Main
  def initialize
    run
  end

  private

  def fetch_user_options
    @input_file_path, @output_file_path = CmdLineOptionParser.new.user_provided_options
  end

  def run
    fetch_user_options
    if output_file_access?
      csv_data = CsvLoader.new(@input_file_path).load_data
      processor = FlightsDataProcessor.new(csv_data)
      output_data = processor.process
      OutputCsvBuilder.new(output_data, @output_file_path).build_and_save_csv
      ErrorsCsvBuilder.new(processor.errors_rows).build_and_save_csv if processor.data_container_errors?
      puts "Success. Data saved to: #{@output_file_path}"
    else
      puts 'Cancelled!'
    end
  rescue Interrupt
    puts 'Interrupted'
  rescue FileNotFoundException
    puts 'Input file was not found under specified path. Aborting!'
    abort
  rescue InvalidCSVFileError
    puts 'Provided input CSV file is malformed. Aborting!'
    abort
  end

  def output_file_access?
    if File.exist?(@output_file_path)
      puts 'Output file already exists. Overwrite? (y/n)'
      decision = nil
      while decision.nil?
        decision_text = gets.chomp
        decision = true if decision_text == 'y'
        decision = false if decision_text == 'n'
      end
      decision
    else
      true
    end
  end
end

Main.new
