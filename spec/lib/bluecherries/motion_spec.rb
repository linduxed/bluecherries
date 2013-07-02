require 'spec_helper'

module BlueCherries
  describe Motion do
    it 'should have sequence of keys' do
      motion = Motion.new(:asdf)

      expect(motion.keys).to eq(:asdf)
    end
  end
end
