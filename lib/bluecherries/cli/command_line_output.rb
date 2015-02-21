module BlueCherries
  # Initiates the password generation process and defines defaults.
  class CommandLineOutput
    def initialize(options = {})
      @generator = options.fetch(:generator,
        BlueCherries::PasswordGenerator.new)
      @amount_of_passwords = options.fetch(:amount_of_passwords, 6)
      @min_password_length = options.fetch(:min_password_length, 16)
      @algorithm_kind = options.fetch(:algorithm_kind,
        BlueCherries::HeadAlgorithm)
      @dictionary_kind = options.fetch(:dictionary_kind,
        BlueCherries::Dictionary)
      @dictionary_path = options.fetch(:dictionary_path, 'english')
      @layout_kind = options.fetch(:layout_kind, BlueCherries::Layout)
      @layout_path = options.fetch(:layout_path, 'qwerty')
    end

    def lines
      amount_of_passwords.times.map do
        generator.generate(algorithm)
      end
    end

    private

    attr_reader :generator, :amount_of_passwords, :min_password_length,
      :algorithm_kind, :dictionary_kind, :dictionary_path, :layout_kind,
      :layout_path

    def algorithm
      algorithm_kind.new(
        dictionary: dictionary,
        layout: layout,
        min_password_length: min_password_length
      )
    end

    def dictionary
      dictionary_kind.new(dictionary_path)
    end

    def layout
      layout_kind.new(layout_path)
    end
  end
end
