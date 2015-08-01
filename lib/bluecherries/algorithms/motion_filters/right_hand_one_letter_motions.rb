module BlueCherries
  class RightHandOneLetterMotions
    def initialize(all_right_hand_motions)
      @all_right_hand_motions = all_right_hand_motions
    end

    def filter
      @all_right_hand_motions.find_all { |motion| motion.keys.count == 1 }
    end
  end
end
