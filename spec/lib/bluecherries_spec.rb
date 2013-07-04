require 'spec_helper'

module BlueCherries
  describe Layout do
    describe '.new' do
      it 'should have default values' do
        expect { Layout.new }.not_to raise_error
      end

      context 'a non-existant layout is provided' do
        it 'should print an error and exit with the code "1"' do
          File.stub(:open) { raise Errno::ENOENT }

          $stderr.should_receive(:puts).with(/ERROR/)
          expect { Layout.new(:foobar) }.to terminate.with_code(1)
        end
      end
    end

    describe '#name' do
      it 'should return a symbol' do
        expect(Layout.new.name).to be_a Symbol
      end
    end

    describe '#keys' do
      it 'should return the layout rows of keys' do
        layout = Layout.new

        expect(layout.keys).not_to be_empty
        expect(layout.keys.all? { |i| i.instance_of? Key }).to be_true
      end
    end

    describe '#motions' do
      it 'should return an array of possible motions' do
        layout = Layout.new

        expect(layout.motions).not_to be_empty
        expect(layout.motions.all? { |i| i.instance_of? Motion }).to be_true
      end
    end
  end

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

  describe Motion do
    describe '#keys' do
      it 'should return a symbol representing the sequence of keys' do
        motion = Motion.new(:asdf)

        expect(motion.keys).to eq(:asdf)
      end
    end
  end
end
