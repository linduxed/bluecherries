require 'spec_helper'

module BlueCherries
  describe Motion do
    describe '#keys' do
      it 'should return a symbol representing the sequence of keys' do
        motion = Motion.new(:asdf)

        expect(motion.keys).to eq(:asdf)
      end
    end
  end
end
