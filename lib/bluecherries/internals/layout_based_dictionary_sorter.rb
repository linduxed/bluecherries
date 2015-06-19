module BlueCherries
  class NonExhaustiveMotionSetError < StandardError; end

  class LayoutBasedDictionarySorter
    def initialize(dictionary, layout)
      @dictionary = dictionary
      @layout = layout
    end

    def sort
      motion_analyzed_words.sort_by(&:value).map(&:to_s)
    end

    private

    attr_reader :dictionary, :layout

    def motion_analyzed_words
      dictionary.words.map { |word| MotionAnalyzedWord.new(word, layout) }
    end
  end

  class MotionAnalyzedWord
    def initialize(word, layout)
      @word = word
      @layout = layout
    end

    def to_s
      @word
    end

    def value
      letters = @word.dup
      matching_motions = []

      until letters.empty?
        match = find_highest_valued_matching_motion(letters)
        remove_letters_from_start_of_word!(letters, match)

        matching_motions << match
      end

      matching_motions.reduce(0) { |sum, motion| sum + motion.value }
    end

    private

    attr_reader :layout

    def find_highest_valued_matching_motion(word)
      motions_sorted_descending_by_value.find(missing_motion) do |motion|
        word.match(/^#{motion.chars}/)
      end
    end

    def motions_sorted_descending_by_value
      @sorted_motions ||= layout.motions.sort_by(&:value).reverse
    end

    def remove_letters_from_start_of_word!(word, motion)
      word.sub!(/^#{motion.chars}/, '')
    end

    def missing_motion
      -> { fail NonExhaustiveMotionSetError }
    end
  end
end
