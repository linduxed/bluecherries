module BlueCherries
  class NoBlockGiven < StandardError; end

  class MotionBanRule
    def initialize(&rule)
      block_given? or fail NoBlockGiven

      @rule = rule
    end

    def banned_motion?(motion)
      @motion = motion

      result = catch(:result) do
        instance_eval(&@rule)
      end

      result
    end

    private

    attr_reader :current_key, :current_index

    def iterate_over_keys_in_motion_with_index
      keys.each.with_index do |key, index|
        @current_key = key
        @current_index = index

        motion_allowed if next_key.nil?

        yield(key, index)
      end
    end

    def keys
      @motion.keys
    end

    def next_key
      keys[current_index + 1]
    end

    def motion_allowed
      throw(:result, false)
    end

    def motion_banned
      throw(:result, true)
    end
  end
end
