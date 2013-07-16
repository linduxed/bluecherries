module BlueCherries
  class CommandLineOutput
    def initialize(generator = BlueCherries::PasswordGenerator.new,
                   algorithm = BlueCherries::HeadAlgorithm.new,
                   dictionary = BlueCherries::Dictionary.new(:english),
                   amount_of_passwords = 6,
                   min_password_length = 16)
      @generator = generator
      @algorithm = algorithm
      @dictionary = dictionary
      @amount_of_passwords = amount_of_passwords
      @min_password_length = min_password_length
    end

    def run
      begin
        @amount_of_passwords.times do
          puts @generator.generate(@algorithm, @dictionary, @min_password_length)
        end
      rescue => error
        $stderr.puts "ERROR: #{error.class} -- #{error.message}"
        exit 1
      end
    end

    private

    attr_reader :output
  end
end
