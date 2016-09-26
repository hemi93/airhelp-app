require 'optparse'

class CmdLineOptionParser
  attr_accessor :options

  def user_provided_options
    @options = { input_file_path: nil, output_file_path: nil }

    parser = OptionParser.new do |opts|
      opts.banner = 'Usage: main.rb [options]'
      opts.on('-i', '--input_path path', 'Input file path') do |input_file_path|
        options[:input_file_path] = input_file_path
      end

      opts.on('-o', '--output_path path', 'Output file path') do |output_file_path|
        options[:output_file_path] = output_file_path
      end

      opts.on('-h', '--help', 'Displays Help') do
        puts opts
        exit
      end
    end

    parser.parse!

    if options[:input_file_path].nil?
      print 'Enter input file path: '
      options[:input_file_path] = gets.chomp
    end

    if options[:output_file_path].nil?
      print 'Enter output file path: '
      options[:output_file_path] = gets.chomp
    end

    raise 'please provide params' unless @options[:input_file_path] && @options[:output_file_path]

    [options[:input_file_path], options[:output_file_path]]
  end
end
