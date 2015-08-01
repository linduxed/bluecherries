require 'spec_helper'

module BlueCherries
  describe Motion do
    describe '#to_s' do
      it 'returns a string with the joined characters of the motion' do
        b = double(char: 'b')
        a = double(char: 'a')
        z = double(char: 'z')
        chars = Motion.new([b, a, z]).to_s

        expect(chars).to eq('baz')
      end
    end

    describe '#value' do
      it 'returns a value larger than zero' do
        motion = Motion.new(double(:keys))

        expect(motion.value).to be > 0
      end
    end

    describe '#==' do
      it 'checks whether the arrays of Keys are identical' do
        q_1 = 'q'
        q_2 = 'q'
        w_1 = 'w'
        w_2 = 'w'

        first_motion = Motion.new([q_1, w_1])
        second_motion = Motion.new([q_2, w_2])

        expect(first_motion == second_motion).to be_truthy
      end
    end
  end
end
