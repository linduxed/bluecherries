module BlueCherries
  class CommandLineOutput
    def initialize(options = {})
      @generator = options.fetch(:generator,
        BlueCherries::PasswordGenerator.new)
      @amount_of_passwords = options.fetch(:amount_of_passwords, 6)
      @min_password_length = options.fetch(:min_password_length, 16)
      @algorithm_kind = options.fetch(:algorithm_kind,
        BlueCherries::HeadAlgorithm)
      @dictionary = options.fetch(:dictionary,
        BlueCherries::Dictionary.new('english'))
    end

    def lines
      passwords = []
      amount_of_passwords.times do
        passwords << generator.generate(algorithm)
      end
      passwords
    end

    private

    attr_reader :generator, :amount_of_passwords, :min_password_length,
      :algorithm_kind, :dictionary

    def algorithm
      algorithm_kind.new(dictionary, min_password_length)
    end
  end
end
