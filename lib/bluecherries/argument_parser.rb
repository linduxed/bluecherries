require 'optparse'

class ArgumentParser
  def initialize(unparsed_args, non_arg_options)
    @unparsed_args = unparsed_args
    @non_arg_options = non_arg_options
  end

  def parse
    parsed_arguments.merge(non_arg_options)
  end

  private

  attr_reader :unparsed_args, :non_arg_options

  def parsed_arguments
    opt_hash = {}

    parser = OptionParser.new do |opts|
      opts.banner = 'Usage: bluecherries [options]'

      opts.on('-n [NUMBER]', Integer,
        'Generate an integer amount of passwords') do |n|
        opt_hash[:amount_of_passwords] = n
      end

      opts.on('-l [NUMBER]', Integer,
        'Passwords need to have at least NUMBER characters') do |n|
        opt_hash[:min_password_length] = n
      end
    end

    parser.parse(unparsed_args)

    opt_hash
  rescue OptionParser::InvalidOption => error
    $stderr.puts "ERROR: #{error}"
    $stderr.puts parser.banner
    exit 64
  end
end
