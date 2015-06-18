module BlueCherries
  class LeftHandTwoLetterMotions
    def initialize(layout_keys)
      @layout_keys = layout_keys
    end

    def generate
      all_possible_motions.reject do |motion|
        forbidden_motion_rules.any? { |rule| rule.banned_motion?(motion) }
      end
    end

    private

    def all_possible_motions
      @all_possible_motions ||= MotionGenerator.new(@layout_keys, 2).left_hand
    end

    def forbidden_motion_rules
      []
    end
  end
end
