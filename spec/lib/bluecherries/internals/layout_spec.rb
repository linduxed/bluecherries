require 'spec_helper'

module BlueCherries
  describe Layout do
    describe '.new' do
      it 'has default values' do
        expect { Layout.new }.not_to raise_error
      end

    end

    describe '#name' do
      it 'returns a symbol' do
        expect(Layout.new.name).to be_a Symbol
      end
    end

    describe '#keys' do
      let(:layout) { Layout.new }

      it 'returns an array of Keys' do
        expect(layout.keys).not_to be_empty
        expect(layout.keys.all? { |i| i.instance_of? Key }).to be_true
      end

      it 'has five left-hand keys on each row' do
        expect(layout).to have_key_count_on_each_row(5).on_hand(:left)
      end

      context 'a non-existant layout was provided upon instantiation' do
        it 'raises an error' do
          File.stub(:open) { raise Errno::ENOENT }

          expect { Layout.new(:foobar).keys }.to raise_error MissingLayoutError
        end
      end
    end

    describe '#motions' do
      it 'returns an array of possible motions' do
        layout = Layout.new

        expect(layout.motions).not_to be_empty
        expect(layout.motions.all? { |i| i.instance_of? Motion }).to be_true
      end
    end
  end
end
