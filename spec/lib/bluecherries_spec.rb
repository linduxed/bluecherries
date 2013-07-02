require 'spec_helper'

module BlueCherries
  describe Layout do
    it 'should have the QWERTY keys when no layout is provided' do
      expect(Layout.new.name).to eq(:qwerty)
    end

    it 'should load a layout if an existing layout is provided' do
      layout = Layout.new(:qwerty)

      expect(layout.keys).not_to be_nil
    end

    it 'should print an error and exit if a non-existant layout is provided' do
      File.stub(:open) { raise Errno::ENOENT }

      STDOUT.should_receive(:puts).with(/ERROR/)
      expect { Layout.new(:foobar) }.to raise_error SystemExit
    end

    it 'should have a name' do
      expect(Layout.new.respond_to? :name).to be_true
    end

    it 'should have an array of keys' do
      layout = Layout.new

      expect(layout.keys).not_to be_empty
      expect(layout.keys.all? { |i| i.instance_of? Key }).to be_true
    end

    it 'should have an array of possible motions' do
      layout = Layout.new

      expect(layout.motions).not_to be_empty
      expect(layout.motions.all? { |i| i.instance_of? Motion }).to be_true
    end
  end

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
        expect { Key.new 'x', :foobar, 3 }.to raise_error BlueCherries::BadHandError
      end
    end
  end

  describe Motion do
    it 'should have sequence of keys' do
      motion = Motion.new(:asdf)

      expect(motion.keys).to eq(:asdf)
    end
  end
end
