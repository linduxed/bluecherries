require 'spec_helper'

module BlueCherries
  describe Key do
    context '.new' do
      it 'raises error when given an invalid hand' do
        expect { Key.new 'x', :foobar, 3 }.to raise_error BlueCherries::BadHandError
      end
    end

    describe '#char' do
      it "should return the Key's character" do
        expect(Key.new('q', :left, 1).char).to eq('q')
      end
    end

    describe '#row_number' do
      it 'should return what row the character is on' do
        expect(Key.new('q', :left, 1).row_number).to eq(1)
      end
    end

    describe '#hand' do
      it 'should return a left or right hand symbol' do
        q_key = Key.new 'q', :left, 1
        j_key = Key.new 'j', :right, 2

        expect(q_key.hand).to eq(:left)
        expect(j_key.hand).to eq(:right)
      end
    end
  end
end
