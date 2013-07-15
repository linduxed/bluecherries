module BlueCherries
  class Dictionary
    attr_reader :words

    def initialize(name = :english)
      begin
        dictionary_file = File.open dictionary_path(name.to_s)
      rescue Errno::ENOENT
        $stderr.puts "ERROR: The dictionary file for #{name.to_s.upcase} "\
                     "doesn't exist."
        exit 1
      end

      @words = dictionary_to_words dictionary_file
    end

    private

    def dictionary_to_words(dictionary_file)
      words = dictionary_file.readlines.map(&:chomp)

      words.reject { |word| word.nil? || word.empty? }
    end

    def dictionary_path(name)
      File.expand_path "../../../dictionaries/#{name}", __FILE__
    end
  end
end
