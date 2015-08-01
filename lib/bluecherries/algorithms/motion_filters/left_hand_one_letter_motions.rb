module BlueCherries
  class LeftHandOneLetterMotions
    def initialize(all_left_hand_motions)
      @all_left_hand_motions = all_left_hand_motions
    end

    def filter
      @all_left_hand_motions.find_all { |motion| motion.keys.count == 1 }
    end
  end
end
