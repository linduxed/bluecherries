require 'bluecherries/algorithms/motion_filters/left_hand_one_letter_motions'
require 'bluecherries/algorithms/motion_filters/left_hand_two_letter_motions'
require 'bluecherries/algorithms/motion_filters/right_hand_one_letter_motions'
require 'bluecherries/algorithms/motion_filters/right_hand_two_letter_motions'

module BlueCherries
  class MotionGenerator
    HORIZONTAL_LEFT_HAND_KEYS = 5

    def initialize(layout)
      @layout = layout
    end

    def left_hand_motions
      [
        LeftHandOneLetterMotions,
        LeftHandTwoLetterMotions
      ].map { |filter| filter.new(all_left_hand_motions) }.map(&:filter).
        flatten
    end

    def right_hand_motions
      [
        RightHandOneLetterMotions,
        RightHandTwoLetterMotions
      ].map { |filter| filter.new(all_right_hand_motions) }.map(&:filter).
        flatten
    end

    def motions
      left_hand_motions + right_hand_motions
    end

    private

    def keys
      @keys ||= @layout.keys
    end

    def left_hand_keys
      keys.find_all do |key|
        key.column < HORIZONTAL_LEFT_HAND_KEYS
      end
    end

    def right_hand_keys
      keys.find_all do |key|
        key.column >= HORIZONTAL_LEFT_HAND_KEYS
      end
    end

    def all_left_hand_motions
      @left_hand_motions ||= (1..4).map do |keys_per_motion|
        left_hand_keys.permutation(keys_per_motion).map do |key_permutation|
          Motion.new(key_permutation)
        end
      end.flatten(1)
    end

    def all_right_hand_motions
      @right_hand_motions ||= (1..4).map do |keys_per_motion|
        right_hand_keys.permutation(keys_per_motion).map do |key_permutation|
          Motion.new(key_permutation)
        end
      end.flatten(1)
    end
  end
end
