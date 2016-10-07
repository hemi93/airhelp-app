require 'optparse'

# Responsible for parsing user options from command line
class CmdLineOptionParser
  attr_reader :options

  def options
    @options = { input_file_path: nil, output_file_path: nil }
    parse_options_from_command_line
    ask_for_input_file_path
    ask_for_output_file_path
    fail_if_invalid_params

    [@options[:input_file_path], @options[:output_file_path]]
  end

  private

  def parse_options_from_command_line
    parser = OptionParser.new do |opts|
      opts.banner = 'Usage: main.rb [options]'
      parse_input_path(opts)
      parse_output_path(opts)
      parse_help_request(opts)
    end

    parser.parse!
  end

  def parse_input_path(opts)
    opts.on('-i', '--input_path path', 'Input file path') do |path|
      @options[:input_file_path] = path
    end
  end

  def parse_output_path(opts)
    opts.on('-o', '--output_path path', 'Output file path') do |path|
      @options[:output_file_path] = path
    end
  end

  def parse_help_request(opts)
    opts.on('-h', '--help', 'Displays Help') do
      puts opts
      exit
    end
  end

  def ask_for_input_file_path
    return unless @options[:input_file_path].nil?
    print 'Enter input file path: '
    @options[:input_file_path] = gets.chomp
  end

  def ask_for_output_file_path
    return unless @options[:output_file_path].nil?
    print 'Enter output file path: '
    @options[:output_file_path] = gets.chomp
  end

  def fail_if_invalid_params
    raise UserProvidedInvalidFilenameError if params_invalid?
  end

  def params_invalid?
    @options[:input_file_path].empty? || @options[:output_file_path].empty?
  end
end
