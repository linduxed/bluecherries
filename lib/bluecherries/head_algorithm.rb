module BlueCherries
  class HeadAlgorithm
    def initialize(dictionary, min_length)
      @dictionary = dictionary
      @min_length = min_length
    end

    def create_password_components
      i = 0
      password_components = []
      while password_components.join.length < @min_length
        password_components << @dictionary.words[i]

        if i < (@dictionary.words.length - 1)
          i += 1
        end
      end

      password_components
    end
  end
end
