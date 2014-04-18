module BlueCherries
  # Handles command line arguments and command line output.
  class CLI
    def initialize(options = {})
      @unparsed_args = options.delete(:args) { ARGV }
      @non_arg_options = options
    end

    def run
      $stdout.puts CommandLineOutput.new(merged_options).lines
    rescue => error
      $stderr.puts "ERROR: #{error.class} -- #{error.message}"
      exit 1
    end

    private

    attr_reader :unparsed_args, :non_arg_options

    def merged_options
      parsed_args.merge(non_arg_options)
    end

    def parsed_args
      ArgumentParser.new(unparsed_args).parse
    end
  end
end
