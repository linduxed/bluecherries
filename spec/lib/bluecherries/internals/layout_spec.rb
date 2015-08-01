require 'spec_helper'

module BlueCherries
  describe Layout do
    describe '.new' do
      it 'has default values' do
        expect { Layout.new }.not_to raise_error
      end
    end

    describe '#keys' do
      context 'malformed layout was provided' do
        it 'raises an error' do
          file = Tempfile.new 'layout_file'
          file.write("qw\nasdf\nz")
          file.close

          expect { Layout.new(file.path).keys }.to raise_error(
            BadLayoutError)
        end
      end

      context 'an empty layout was provided' do
        it 'raises an error' do
          file = Tempfile.new 'layout_file'
          file.close

          expect { Layout.new(file.path).keys }.to raise_error(
            BadLayoutError)
        end
      end

      context 'a path to a non-existant dictionary was provided' do
        it 'raises an error' do
          expect { Layout.new('foo.bar.baz').keys }.to raise_error(
            MissingLayoutError)
        end
      end
    end
  end
end
