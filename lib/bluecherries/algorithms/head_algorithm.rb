module BlueCherries
  # Takes words from the start of the dictionary until the length is satisfied.
  class HeadAlgorithm < Algorithm
    def initialize(dictionary, min_length)
      @dictionary = dictionary
      @min_length = min_length
    end

    def create_password_components
      password_components = []

      while password_components.join.length < min_length
        password_components << next_word
      end

      password_components
    end

    private

    attr_reader :min_length, :dictionary

    def next_word
      word_enumerator.next
    rescue StopIteration
      dictionary.words.last
    end

    def word_enumerator
      @word_enumerator ||= dictionary.words.to_enum
    end
  end
end
