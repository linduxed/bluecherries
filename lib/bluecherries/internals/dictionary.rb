module BlueCherries
  class MissingDictionaryError < Exception; end
  class EmptyDictionaryError < Exception; end

  # Transforms a plaintext dictionary file into an array of words.
  class Dictionary
    def initialize(input_path = 'english')
      @input_path = input_path
    end

    def words
      @words ||= extract_words_from_dictionary_file
    end

    private

    def extract_words_from_dictionary_file
      words = lines_from_dictionary.reject do |word|
        word.nil? || word.empty? || word =~ /^\s+$/
      end

      words.map!(&:downcase)

      fail EmptyDictionaryError if words.empty?

      words
    end

    def lines_from_dictionary
      File.readlines(dictionary_path).map(&:chomp)
    rescue Errno::ENOENT
      raise MissingDictionaryError,
        "ERROR: The dictionary file '#{@input_path}' doesn't exist."
    end

    def dictionary_path
      full_paths = search_path_prefixes.map do |prefix|
        File.expand_path @input_path, prefix
      end

      full_paths.find { |path| File.exist? path } || ''
    end

    def search_path_prefixes
      [
        __FILE__ + '/../../../../dictionaries/',
        '',
        Dir.pwd + '/'
      ]
    end
  end
end
