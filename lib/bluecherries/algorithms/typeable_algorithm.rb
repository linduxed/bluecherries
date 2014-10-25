module BlueCherries
  # Finds words that are easy to type for specific keyboard layouts
  class TypeableAlgorithm < Algorithm
    def initialize(options)
      @dictionary = options[:dictionary]
      @min_password_length = options[:min_password_length]
      @layout = options[:layout]
    end

    def create_password_components
      password_components = []

      while password_components.join.length < min_password_length
        password_components << next_word
      end

      password_components
    end

    private

    attr_reader :dictionary, :min_password_length, :layout

    def next_word
      sorted_dictionary_enumerator.next
    rescue StopIteration
      sorted_dictionary.first
    end

    def sorted_dictionary_enumerator
      @sorted_dictionary_enumerator ||= sorted_dictionary.to_enum
    end

    def sorted_dictionary
      @sorted_dictionary ||= LayoutBasedDictionarySorter.new(
        dictionary, layout).sort
    end
  end
end
