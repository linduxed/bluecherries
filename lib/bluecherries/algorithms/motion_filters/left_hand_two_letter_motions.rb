module BlueCherries
  class LeftHandTwoLetterMotions
    def initialize(all_left_hand_motions)
      @all_left_hand_motions = all_left_hand_motions
    end

    def filter
      two_letter_motions.reject do |motion|
        forbidden_motion_rules.any? { |rule| rule.banned_motion?(motion) }
      end
    end

    private

    def two_letter_motions
      @all_left_hand_motions.find_all { |motion| motion.keys.count == 2 }
    end

    def forbidden_motion_rules
      [
        MotionBanRule.new do
          iterate_over_keys_in_motion_with_index do |current_key, _|
            motion_banned if (current_key.row - next_key.row).abs > 1 &&
                (current_key.column - next_key.column).abs < 4
          end
        end,
        MotionBanRule.new do
          iterate_over_keys_in_motion_with_index do |current_key, _|
            motion_banned if current_key.column > 2 &&
                (current_key.row - next_key.row) > 0 &&
                (next_key.column - current_key.column) == 1
          end
        end,
        MotionBanRule.new do
          iterate_over_keys_in_motion_with_index do |current_key, _|
            motion_banned if current_key.row > 0 &&
                next_key.row > 0 &&
                current_key.column < 1 &&
                (current_key.row - next_key.row).abs == 1 &&
                next_key.column == current_key.column
          end
        end,
        MotionBanRule.new do
          iterate_over_keys_in_motion_with_index do |current_key, _|
            motion_banned if current_key.row < 2 &&
                next_key.row < 2 &&
                current_key.column < 2 &&
                (current_key.row - next_key.row).abs == 1 &&
                next_key.column == current_key.column
          end
        end
      ]
    end
  end
end
