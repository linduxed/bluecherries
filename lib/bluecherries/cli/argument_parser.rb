require 'optparse'

class ArgumentParser
  def initialize(unparsed_args)
    @unparsed_args = unparsed_args
  end

  def parse
    opt_hash = {}

    parser = OptionParser.new do |opts|
      opts.banner = 'Usage: bluecherries [options]'

      opts.on('-n [NUMBER]', Integer,
        'Generate NUMBER passwords') do |n|
        opt_hash[:amount_of_passwords] = n
      end

      opts.on('-l [NUMBER]', Integer,
        'At least NUMBER characters') do |n|
        opt_hash[:min_password_length] = n
      end

      opts.on('-d [DICTIONARY]',
        'Absolute path or one of default dictionaries') do |n|
        opt_hash[:dictionary_path] = n
      end
    end

    parser.parse(unparsed_args)

    opt_hash
  rescue OptionParser::InvalidOption => error
    $stderr.puts "ERROR: #{error}"
    $stderr.puts parser.banner
    exit 64
  end

  private

  attr_reader :unparsed_args
end
