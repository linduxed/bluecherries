module BlueCherries
  class PasswordGenerator
    def generate(algorithm, dictionary, min_length)
      password_components = algorithm.create_password_components(dictionary,
        min_length)

      Password.new camel_case(password_components).join
    end

    private

    def camel_case(words)
      [words.first] << words.drop(1).map(&:capitalize)
    end
  end
end
