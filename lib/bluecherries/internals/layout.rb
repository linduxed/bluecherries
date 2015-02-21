module BlueCherries
  class MissingLayoutError < StandardError; end
  class BadLayoutError < StandardError; end

  class Layout
    def initialize(path = 'qwerty')
      @path = path
    end

    def left_hand_motions
      []
    end

    private

    attr_reader :path

    def chars
      @chars ||= extract_character_rows_from_layout_file
    end

    def extract_character_rows_from_layout_file
      layout_rows = rows_from_layout.map(&:downcase).map(&:chars)

      unless valid_layout?(layout_rows)
        raise BadLayoutError
      end

      layout_rows
    end

    def rows_from_layout
      File.readlines(layout_path).map(&:chomp)
    rescue Errno::ENOENT
      raise MissingLayoutError,
        "ERROR: The layout file '#{path}' doesn't exist."
    end

    def valid_layout?(rows)
      !rows.empty? &&
        rows.none?(&:empty?) &&
        rows.all? { |row| row.length >= 7 }
    end

    def layout_path
      full_paths = search_path_prefixes.map do |prefix|
        File.expand_path(path, prefix)
      end

      full_paths.find { |path| File.exists? path } || ''
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
