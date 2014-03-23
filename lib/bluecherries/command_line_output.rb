module BlueCherries
  # Handles command line arguments and command line output.
  class CommandLineOutput
    def initialize(options = {})
      @unparsed_args = options.fetch(:args, ARGV)
      @generator = options.fetch(:generator,
        BlueCherries::PasswordGenerator.new)
      @amount_of_passwords = options.fetch(:amount_of_passwords, 6)
      @min_password_length = options.fetch(:min_password_length, 16)
      @algorithm_kind = options.fetch(:algorithm_kind,
        BlueCherries::HeadAlgorithm)
      @dictionary = options.fetch(:dictionary,
        BlueCherries::Dictionary.new('english'))
    end

    def run
      amount_of_passwords.times { puts generator.generate(algorithm) }
    rescue => error
      $stderr.puts "ERROR: #{error.class} -- #{error.message}"
      exit 1
    end

    private

    attr_reader :algorithm_kind, :dictionary, :generator, :min_password_length,
      :amount_of_passwords

    def algorithm
      algorithm_kind.new(dictionary, min_password_length)
    end
  end
end
