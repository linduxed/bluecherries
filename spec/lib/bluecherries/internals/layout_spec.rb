require 'spec_helper'

module BlueCherries
  describe Layout do
    describe '.new' do
      it 'has default values' do
        expect { Layout.new }.not_to raise_error
      end
    end

    describe '#keys' do
      context 'valid layout was provided' do
        it 'returns a list of keys corresponding to the layout file' do
          file = Tempfile.new 'layout_file'
          file.write("qwertyuiop\nasdfghjkl\nzxcvbnm")
          file.close

          keys = Layout.new(file.path).keys

          expect(keys).to include(
            Key.new('q', 0, 0),
            Key.new('w', 0, 1),
            Key.new('e', 0, 2),
            Key.new('r', 0, 3),
            Key.new('t', 0, 4),
            Key.new('y', 0, 5),
            Key.new('u', 0, 6),
            Key.new('i', 0, 7),
            Key.new('o', 0, 8),
            Key.new('p', 0, 9),
            Key.new('a', 1, 0),
            Key.new('s', 1, 1),
            Key.new('d', 1, 2),
            Key.new('f', 1, 3),
            Key.new('g', 1, 4),
            Key.new('h', 1, 5),
            Key.new('j', 1, 6),
            Key.new('k', 1, 7),
            Key.new('l', 1, 8),
            Key.new('z', 2, 0),
            Key.new('x', 2, 1),
            Key.new('c', 2, 2),
            Key.new('v', 2, 3),
            Key.new('b', 2, 4),
            Key.new('n', 2, 5),
            Key.new('m', 2, 6)
          )

          file.delete
        end
      end

      context 'malformed layout was provided' do
        it 'raises an error' do
          file = Tempfile.new 'layout_file'
          file.write("qw\nasdf\nz")
          file.close

          expect { Layout.new(file.path).keys }.to raise_error(
            BadLayoutError)

          file.delete
        end
      end

      context 'an empty layout was provided' do
        it 'raises an error' do
          file = Tempfile.new 'layout_file'
          file.close

          expect { Layout.new(file.path).keys }.to raise_error(
            BadLayoutError)

          file.delete
        end
      end

      context 'a path to a non-existant dictionary was provided' do
        it 'raises an error' do
          expect { Layout.new('foo.bar.baz').keys }.to raise_error(
            MissingLayoutError)

          file.delete
        end
      end
    end
  end
end
