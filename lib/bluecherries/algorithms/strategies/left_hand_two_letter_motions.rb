module BlueCherries
  class LeftHandTwoLetterMotions
    HORIZONTAL_LEFT_HAND_KEYS = 5

    def initialize(layout_keys)
      @layout_keys = layout_keys
    end

    def generate
      MotionGenerator.new(left_hand_key_rows, 2, restrictions).generate
    end

    private

    attr_reader :layout_keys

    def left_hand_key_rows
      layout_keys.map { |row| row.first(HORIZONTAL_LEFT_HAND_KEYS) }
    end

    def restrictions
      []
    end
  end
end
