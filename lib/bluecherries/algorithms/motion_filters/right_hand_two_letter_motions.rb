module BlueCherries
  class RightHandTwoLetterMotions
    def initialize(all_right_hand_motions)
      @all_right_hand_motions = all_right_hand_motions
    end

    def filter
      two_letter_motions.reject do |motion|
        forbidden_motion_rules.any? { |rule| rule.banned_motion?(motion) }
      end
    end

    private

    def two_letter_motions
      @all_right_hand_motions.find_all { |motion| motion.keys.count == 2 }
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
