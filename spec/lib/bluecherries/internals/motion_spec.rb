require 'spec_helper'

module BlueCherries
  describe Motion do
    describe '#chars' do
      it 'returns a string with the joined characters of the motion' do
        b = double(char: 'b')
        a = double(char: 'a')
        z = double(char: 'z')
        chars = Motion.new([b, a, z]).chars

        expect(chars).to eq('baz')
      end
    end
  end
end
