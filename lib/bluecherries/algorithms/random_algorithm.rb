module BlueCherries
  class RandomAlgorithm < Algorithm
    def initialize(dictionary, min_password_length)
      @dictionary = dictionary
      @min_password_length = min_password_length
    end

    def create_password_components
      password_components = []

      while password_components.join.length < min_password_length
        password_components << dictionary.words.sample
      end

      password_components
    end

    private

    attr_reader :dictionary, :min_password_length
  end
end
