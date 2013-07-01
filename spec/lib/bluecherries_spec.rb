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

    it 'should have an array of possible motions' do
      layout = Layout.new

      expect(layout.motions.all? { |i| i.instance_of? Motion }).to be_true
    end
  end

  describe Motion do
    it 'should have sequence of keys' do
      motion = Motion.new(:asdf)

      expect(motion.keys).to eq(:asdf)
    end
  end
end
