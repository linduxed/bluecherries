module BlueCherries
  class PasswordGenerator
    def generate(algorithm)
      password_components = algorithm.create_password_components

      Password.new(camel_case(password_components).join)
    end

    private

    def camel_case(words)
      [words.first] << words.drop(1).map(&:capitalize)
    end
  end
end
