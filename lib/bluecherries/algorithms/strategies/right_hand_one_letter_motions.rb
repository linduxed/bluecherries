module BlueCherries
  class RightHandOneLetterMotions
    def initialize(layout_keys)
      @layout_keys = layout_keys
    end

    def generate
      @layout_keys.map { |row| row.drop(5) }.flatten.map do |key|
        Motion.new([key])
      end
    end
  end
end
