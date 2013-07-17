module BlueCherries
  class MissingDictionaryError < Exception; end
  class EmptyDictionaryError < Exception; end

  class Dictionary
    def initialize(name = :english)
      @name = name
    end

    def words
      @words ||= extract_words_from_dictionary_file
    end

    private

    def extract_words_from_dictionary_file
      begin
        dictionary_file = File.open dictionary_path
        words = dictionary_to_words dictionary_file
        dictionary_file.close
      rescue Errno::ENOENT
        raise MissingDictionaryError, "ERROR: The dictionary file for "\
                                      "#{@name.to_s.upcase} doesn't exist."
      end

      if words.empty?
        raise EmptyDictionaryError
      end

      words
    end

    def dictionary_to_words(dictionary_file)
      words = dictionary_file.readlines.map(&:chomp)

      words.reject { |word| word.nil? || word.empty? }
    end

    def dictionary_path
      File.expand_path "../../../dictionaries/#{@name.to_s}", __FILE__
    end
  end
end
