module BlueCherries
  class MotionGenerator
    HORIZONTAL_LEFT_HAND_KEYS = 5

    def initialize(key_rows, keys_per_motion)
      @key_rows = key_rows
      @keys_per_motion = keys_per_motion
    end

    def all
      all_permutations(@key_rows)
    end

    def left_hand
      all_permutations(left_hand_key_rows)
    end

    def right_hand
      all_permutations(right_hand_key_rows)
    end

    private

    def all_permutations(key_rows)
      key_rows.flatten.permutation(@keys_per_motion).map do |keys|
        Motion.new(keys)
      end
    end

    def left_hand_key_rows
      @key_rows.map do |row|
        row.first(HORIZONTAL_LEFT_HAND_KEYS)
      end
    end

    def right_hand_key_rows
      @key_rows.map do |row|
        row.drop(HORIZONTAL_LEFT_HAND_KEYS)
      end
    end
  end
end
