require 'spec_helper'

module BlueCherries
  describe Key do
    it 'should correspond to a character' do
      expect(Key.new('q', :left, 1).send(:char)).to eq('q')
    end

    it 'should know what row the character is on' do
      expect(Key.new('q', :left, 1).send(:row_number)).to eq(1)
    end

    it 'should belong to the left or right hand' do
      q_key = Key.new 'q', :left, 1
      j_key = Key.new 'j', :right, 2

      expect(q_key.send(:hand)).to eq(:left)
      expect(j_key.send(:hand)).to eq(:right)
      expect { Key.new 'x', :foobar, 3 }.to raise_error BadHandError
    end
  end
end
