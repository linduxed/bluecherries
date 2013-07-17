module BlueCherries
  class HeadAlgorithm
    def initialize(dictionary, min_length)
      @dictionary = dictionary
      @min_length = min_length
    end

    def create_password_components
      words = @dictionary.words.to_enum
      password_components = []

      while password_components.join.length < @min_length
        begin
          password_components << words.next
        rescue StopIteration
          password_components << password_components.last
        end
      end

      password_components
    end
  end
end
