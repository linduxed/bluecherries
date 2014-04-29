require 'optparse'

module BlueCherries
  class ArgumentParser
    def initialize(unparsed_args)
      @unparsed_args = unparsed_args
    end

    def parse
      opt_hash = {}

      parser = OptionParser.new do |opts|
        opts.banner = 'Usage: bluecherries [options]'

        opts.on('-n [NUMBER]', Integer,
          'Generate NUMBER passwords') do |number|
          opt_hash[:amount_of_passwords] = number
        end

        opts.on('-l [NUMBER]', Integer,
          'At least NUMBER characters') do |number|
          opt_hash[:min_password_length] = number
        end

        opts.on('-d [DICTIONARY]',
          'Absolute/relative path or default dicts.') do |dictionary_path|
          opt_hash[:dictionary_path] = dictionary_path
        end

        opts.on('-a [ALGORITHM]',
          'Name of one of the provided algorithms.') do |algorithm_name|
          opt_hash[:algorithm_kind] = AlgorithmFinder.new(algorithm_name).find
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
end
