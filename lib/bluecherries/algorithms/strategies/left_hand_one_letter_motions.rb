module BlueCherries
  class LeftHandOneLetterMotions
    def initialize(layout_chars)
      @layout_chars = layout_chars
    end

    def generate
      layout_chars.map { |row| row.first(5) }.flatten
    end

    private

    attr_reader :layout_chars
  end
end
