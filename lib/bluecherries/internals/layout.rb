require 'bluecherries/algorithms/strategies/left_hand_one_letter_motions'
require 'bluecherries/algorithms/strategies/left_hand_two_letter_motions'

module BlueCherries
  class MissingLayoutError < StandardError; end
  class BadLayoutError < StandardError; end

  Key = Struct.new(:char, :row, :column)

  class Layout
    def initialize(path = 'qwerty')
      @path = path
    end

    def left_hand_motions
      [
        LeftHandOneLetterMotions,
        LeftHandTwoLetterMotions
      ].map { |strategy| strategy.new(keys) }.map(&:generate).flatten
    end

    private

    def keys
      @keys ||= extract_character_rows_from_layout_file.
        map.with_index do |row_of_chars, row_index|
        row_of_chars.map.with_index do |char, column_index|
          Key.new(char, row_index, column_index)
        end
      end
    end

    def extract_character_rows_from_layout_file
      layout_rows = rows_from_layout.map(&:downcase).map(&:chars)

      valid_layout?(layout_rows) or fail BadLayoutError

      layout_rows
    end

    def rows_from_layout
      File.readlines(layout_path).map(&:chomp)
    rescue Errno::ENOENT
      raise MissingLayoutError,
        "ERROR: The layout file '#{@path}' doesn't exist."
    end

    def valid_layout?(rows)
      !rows.empty? &&
        rows.none?(&:empty?) &&
        rows.all? { |row| row.length >= 7 }
    end

    def layout_path
      full_paths = search_path_prefixes.map do |prefix|
        File.expand_path(@path, prefix)
      end

      full_paths.find { |path| File.exist? path } || ''
    end

    def search_path_prefixes
      [
        __FILE__ + '/../../../../layouts/',
        '',
        Dir.pwd + '/'
      ]
    end
  end
end
