require 'spec_helper'
require 'bluecherries/internals/motion'

module BlueCherries
  describe MotionGenerator do
    describe '#left_hand_motions' do
      it 'returns motions only comprised from left hand keys' do
        layout = double(:layout, keys: layout_keys)

        generated_motions = MotionGenerator.new(layout).left_hand_motions

        letters_of_all_motions = generated_motions.map(&:to_s).map(&:chars).
          flatten.uniq
        expect(letters_of_all_motions).to include(
          *%w(q w e r t a s d f g z x c v b)
        )
        expect(letters_of_all_motions).not_to include(
          *%w(y u i o p h j k l n m)
        )
      end
    end

    describe '#right_hand_motions' do
      it 'returns motions only comprised from right hand keys' do
        layout = double(:layout, keys: layout_keys)

        generated_motions = MotionGenerator.new(layout).right_hand_motions

        letters_of_all_motions = generated_motions.map(&:to_s).map(&:chars).
          flatten.uniq
        expect(letters_of_all_motions).to include(
          *%w(y u i o p h j k l n m)
        )
        expect(letters_of_all_motions).not_to include(
          *%w(q w e r t a s d f g z x c v b)
        )
      end
    end

    def layout_keys
      [
        double(char: 'q', row: 0, column: 0),
        double(char: 'w', row: 0, column: 1),
        double(char: 'e', row: 0, column: 2),
        double(char: 'r', row: 0, column: 3),
        double(char: 't', row: 0, column: 4),
        double(char: 'y', row: 0, column: 5),
        double(char: 'u', row: 0, column: 6),
        double(char: 'i', row: 0, column: 7),
        double(char: 'o', row: 0, column: 8),
        double(char: 'p', row: 0, column: 9),
        double(char: 'a', row: 1, column: 0),
        double(char: 's', row: 1, column: 1),
        double(char: 'd', row: 1, column: 2),
        double(char: 'f', row: 1, column: 3),
        double(char: 'g', row: 1, column: 4),
        double(char: 'h', row: 1, column: 5),
        double(char: 'j', row: 1, column: 6),
        double(char: 'k', row: 1, column: 7),
        double(char: 'l', row: 1, column: 8),
        double(char: 'z', row: 2, column: 0),
        double(char: 'x', row: 2, column: 1),
        double(char: 'c', row: 2, column: 2),
        double(char: 'v', row: 2, column: 3),
        double(char: 'b', row: 2, column: 4),
        double(char: 'n', row: 2, column: 5),
        double(char: 'm', row: 2, column: 6)
      ]
    end
  end
end
