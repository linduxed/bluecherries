module BlueCherries
  class CommandLineOutput
    def initialize(opts = {})
      @unparsed_args = opts.fetch(:args, ARGV)
      @generator = opts.fetch(:generator, BlueCherries::PasswordGenerator.new)
      @amount_of_passwords = opts.fetch(:amount_of_passwords, 6)

      min_password_length = opts.fetch(:min_password_length, 16)
      algorithm = opts.fetch(:algorithm, BlueCherries::HeadAlgorithm)
      dictionary = opts.fetch(:dict, BlueCherries::Dictionary.new('english'))
      @algorithm = algorithm.new dictionary, min_password_length
    end

    def run
      @amount_of_passwords.times { puts @generator.generate(@algorithm) }
    rescue => error
      $stderr.puts "ERROR: #{error.class} -- #{error.message}"
      exit 1
    end
  end
end
