module BlueCherries
  class RightHandTwoLetterMotions
    def initialize(layout_keys)
      @layout_keys = layout_keys
    end

    def filter
      all_possible_motions.reject do |motion|
        forbidden_motion_rules.any? { |rule| rule.banned_motion?(motion) }
      end
    end

    private

    def all_possible_motions
      @all_possible_motions ||= MotionGenerator.new(@layout_keys, 2).right_hand
    end

    def forbidden_motion_rules
      [
        MotionBanRule.new do
          iterate_over_keys_in_motion_with_index do |current_key, _|
            motion_banned if current_key.column == next_key.column
          end
        end,
        MotionBanRule.new do
          iterate_over_keys_in_motion_with_index do |current_key, _|
            motion_banned if next_key.column - current_key.column == 1 &&
                next_key.row - current_key.row == 1
          end
        end,
        MotionBanRule.new do
          iterate_over_keys_in_motion_with_index do |current_key, _|
            motion_banned if current_key.column - next_key.column == 1 &&
                current_key.row - next_key.row == 1
          end
        end
      ]
    end
  end
end
