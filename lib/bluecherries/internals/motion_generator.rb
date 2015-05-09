module BlueCherries
  class MotionGenerator
    def initialize(key_rows, keys_per_motion, forbidden_motions)
      @key_rows = key_rows
      @keys_per_motion = keys_per_motion
      @forbidden_motions = forbidden_motions
    end

    def generate
      all_possible_motions.reject do |motion|
        forbidden_motions.any? { |f_motion| f_motion == motion }
      end
    end

    private

    attr_reader :key_rows, :keys_per_motion, :forbidden_motions

    def all_possible_motions
      key_rows.flatten.permutation(keys_per_motion).map do |keys|
        Motion.new(keys)
      end
    end
  end
end
