module BlueCherries
  class MissingDictionaryError < Exception; end
  class EmptyDictionaryError < Exception; end

  class Dictionary
    def initialize(path = 'english')
      @path = path
    end

    def words
      @words ||= extract_words_from_dictionary_file
    end

    private

    def extract_words_from_dictionary_file
      begin
        dictionary = File.readlines(dictionary_path).map(&:chomp)
        words = dictionary_to_words dictionary
      rescue Errno::ENOENT
        raise MissingDictionaryError, "ERROR: The dictionary file "\
                                      "'#{@path}' doesn't exist."
      end

      if words.empty?
        raise EmptyDictionaryError
      end

      words
    end

    def dictionary_to_words(dictionary)
      dictionary.reject { |word| word.nil? || word.empty? }
    end

    def dictionary_path
      search_paths = [
        __FILE__ + '/../../../dictionaries/',
        Dir.pwd + '/',
        ''
      ]

      valid_search_path = search_paths.find do |search_path|
        file_path = File.expand_path @path, search_path
        File.exists? file_path
      end

      File.expand_path @path, valid_search_path
    end
  end
end
