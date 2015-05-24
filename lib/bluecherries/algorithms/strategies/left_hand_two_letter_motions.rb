module BlueCherries
  class LeftHandTwoLetterMotions
    def initialize(layout_keys)
      @layout_keys = layout_keys
    end

    def generate
      MotionGenerator.new(@layout_keys, 2).left_hand
    end
  end
end
