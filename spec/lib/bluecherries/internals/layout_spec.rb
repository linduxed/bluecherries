require 'spec_helper'

module BlueCherries
  describe Layout do
    describe '.new' do
      it 'has default values' do
        expect { Layout.new }.not_to raise_error
      end
    end

    it 'raises an error if a malformed layout is provided' do
      file = Tempfile.new 'layout_file'
      file.write("qw\nasdf\nz")
      file.close

      expect { Layout.new(file.path).keys }.to raise_error(
        BadLayoutError)
    end

    it 'raises an error if an empty layout is provided' do
      file = Tempfile.new 'layout_file'
      file.close

      expect { Layout.new(file.path).keys }.to raise_error(
        BadLayoutError)
    end

    context 'a path to a non-existant dictionary was provided' do
      it 'raises an error' do
        expect { Layout.new('foo.bar.baz').keys }.to raise_error(
          MissingLayoutError)
      end
    end
  end
end
