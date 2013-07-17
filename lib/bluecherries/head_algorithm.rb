module BlueCherries
  class HeadAlgorithm
    def initialize(dictionary, min_length)
      @dictionary = dictionary
      @min_length = min_length
      @words = dictionary.words.to_enum
    end

    def create_password_components
      password_components = []

      while password_components.join.length < @min_length
        password_components << next_word
      end

      password_components
    end

    private

    def next_word
      @word = @words.next
      @word
    rescue StopIteration
      @word
    end
  end
end
