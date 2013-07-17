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
      words = lines_from_dictionary.reject do |word|
        word.nil? || word.empty? || word =~ /^\s+$/
      end

      words.map(&:downcase!)

      if words.empty?
        raise EmptyDictionaryError
      end

      words
    end

    def lines_from_dictionary
      File.readlines(dictionary_path).map(&:chomp)
    rescue Errno::ENOENT
      raise MissingDictionaryError, "ERROR: The dictionary file '#{@path}' "\
                                    "doesn't exist."
    end

    def dictionary_path
      full_paths = search_paths.map do |search_path|
        File.expand_path @path, search_path
      end

      full_paths.find { |path| File.exists? path } || ''
    end

    def search_paths
      [__FILE__ + '/../../../dictionaries/', Dir.pwd + '/', '']
    end
  end
end
