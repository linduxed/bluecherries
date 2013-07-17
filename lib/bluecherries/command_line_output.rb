module BlueCherries
  class CommandLineOutput
    def initialize(generator = BlueCherries::PasswordGenerator.new,
                   algorithm = BlueCherries::HeadAlgorithm,
                   dictionary = BlueCherries::Dictionary.new('english'),
                   amount_of_passwords = 6,
                   min_password_length = 16)
      @generator = generator
      @algorithm = algorithm.new dictionary, min_password_length
      @amount_of_passwords = amount_of_passwords
    end

    def run
      @amount_of_passwords.times { puts @generator.generate(@algorithm) }
    rescue => error
      $stderr.puts "ERROR: #{error.class} -- #{error.message}"
      exit 1
    end
  end
end
