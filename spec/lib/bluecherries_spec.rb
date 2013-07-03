require 'spec_helper'

module BlueCherries
  describe Layout do
    describe '#name' do
      it 'should have the QWERTY keys when no layout is provided' do
        expect(Layout.new.name).to eq(:qwerty)
      end

      it 'should exist' do
        expect(Layout.new.respond_to? :name).to be_true
      end
    end

    describe '#new' do
      it 'should load a layout if an existing layout is provided' do
        layout = Layout.new(:qwerty)

        expect(layout.keys).not_to be_nil
      end

      context 'a non-existant layout is provided' do
        it 'should print an error and exit' do
          File.stub(:open) { raise Errno::ENOENT }

          STDERR.should_receive(:puts).with(/ERROR/)
          expect { Layout.new(:foobar) }.to raise_error SystemExit
        end

        it 'should return with the exit code "1"' do
          expect { Layout.new(:foobar) }.to terminate.with_code(1)
        end
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

  describe Motion do
    describe '#new' do
      it 'should have sequence of keys' do
        motion = Motion.new(:asdf)

        expect(motion.keys).to eq(:asdf)
      end
    end
  end
end
