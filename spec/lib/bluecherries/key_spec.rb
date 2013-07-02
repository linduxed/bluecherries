require 'spec_helper'

module BlueCherries
  describe Key do
    it 'should correspond to a character' do
      expect(Key.new('q', :left, 1).char).to eq('q')
    end

    it 'should know what row the character is on' do
      expect(Key.new('q', :left, 1).row_number).to eq(1)
    end

    it 'should belong to the left or right hand' do
      q_key = Key.new 'q', :left, 1
      j_key = Key.new 'j', :right, 2

      expect(q_key.hand).to eq(:left)
      expect(j_key.hand).to eq(:right)
    end

    context '.new' do
      it 'raises error when given an invalid hand' do
        expect { Key.new 'x', :foobar, 3 }.to raise_error BadHandError
      end
    end
  end
end
