require 'optparse'

module BlueCherries
  # Defines what options are available to the CLI.
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

        opts.on('-c [NUMBER]', Integer,
          'At least NUMBER characters') do |number|
          if number > 0
            opt_hash[:min_password_length] = number
          else
            fail(OptionParser::InvalidArgument, 'bad minimum password length')
          end
        end

        opts.on('-d [DICTIONARY]',
          'Absolute/relative path or default dicts.') do |dictionary_path|
          opt_hash[:dictionary_path] = dictionary_path
        end

        opts.on('-a [ALGORITHM]',
          'Name of one of the provided algorithms.') do |algorithm_name|
          if algorithm_name.nil?
            algorithm_names = Algorithm.names_of_all_algorithms.join(', ')

            fail(
              OptionParser::MissingArgument,
              "missing algorithm name\n" \
              "available algorithms: #{algorithm_names}"
            )
          else
            opt_hash[:algorithm_kind] = AlgorithmFinder.new(
              algorithm_name).find
          end
        end

        opts.on('-l [LAYOUT]',
          'Absolute/relative path or default layouts.') do |layout_path|
          opt_hash[:layout_path] = layout_path
        end
      end

      parser.parse(unparsed_args)

      opt_hash
    rescue => error
      $stderr.puts parser.banner
      raise error
    end

    private

    attr_reader :unparsed_args
  end
end
