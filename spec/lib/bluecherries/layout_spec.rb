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
      let(:layout) { Layout.new }

      it 'should return an array of Keys' do
        expect(layout.keys).not_to be_empty
        expect(layout.keys.all? { |i| i.instance_of? Key }).to be_true
      end

      it 'should have five left-hand keys on each row' do
        left_hand_keys = layout.keys.select { |key| key.hand == :left }
        rows = left_hand_keys.group_by { |key| key.row_number }.values

        expect(rows.all? { |row| row.length == 5 }).to be_true
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
end
