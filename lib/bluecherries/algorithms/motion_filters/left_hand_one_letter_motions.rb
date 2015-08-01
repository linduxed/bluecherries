module BlueCherries
  class LeftHandOneLetterMotions
    def initialize(layout_keys)
      @layout_keys = layout_keys
    end

    def generate
      @layout_keys.map { |row| row.first(5) }.flatten.map do |key|
        Motion.new([key])
      end
    end
  end
end
