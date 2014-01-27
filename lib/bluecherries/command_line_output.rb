module BlueCherries
  class CommandLineOutput
    def initialize(opts = {})
      @unparsed_args = opts.fetch(:args, ARGV)
      @generator = opts.fetch(:generator, BlueCherries::PasswordGenerator.new)
      @amount_of_passwords = opts.fetch(:amount_of_passwords, 6)
      @min_password_length = opts.fetch(:min_password_length, 16)
      @algorithm_kind = opts.fetch(:algorithm_kind, BlueCherries::HeadAlgorithm)
      @dictionary = opts.fetch(:dict, BlueCherries::Dictionary.new('english'))
    end

    def run
      @amount_of_passwords.times { puts @generator.generate(algorithm) }
    rescue => error
      $stderr.puts "ERROR: #{error.class} -- #{error.message}"
      exit 1
    end

    private

    attr_reader :algorithm_kind, :dictionary, :min_password_length

    def algorithm
      algorithm_kind.new dictionary, min_password_length
    end
  end
end
