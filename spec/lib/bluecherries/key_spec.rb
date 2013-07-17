require 'spec_helper'

module BlueCherries
  describe Key do
    describe '#char' do
      it "returns the Key's character" do
        expect(Key.new('q', 1, 1).char).to eq('q')
      end
    end

    describe '#row_number' do
      it 'returns what row the character is on' do
        expect(Key.new('q', 1, 1).row_number).to eq(1)
      end
    end

    describe '#hand' do
      it 'returns a left or right hand symbol' do
        q_key = Key.new 'q', 1, 1
        j_key = Key.new 'j', 7, 2

        expect(q_key.hand).to eq(:left)
        expect(j_key.hand).to eq(:right)
      end
    end
  end
end
