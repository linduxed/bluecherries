module BlueCherries
  class RandomAlgorithm
    def initialize(dictionary, min_length)
      @dictionary = dictionary
      @min_length = min_length
    end

    def create_password_components
      password_components = []

      while password_components.join.length < min_length
        password_components << dictionary.words.sample
      end

      password_components
    end

    private

    attr_reader :dictionary, :min_length
  end
end
