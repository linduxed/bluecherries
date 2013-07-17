require 'spec_helper'

module BlueCherries
  describe Dictionary do
    describe '.new' do
      it 'has default values' do
        expect { Dictionary.new }.not_to raise_error
      end
    end

    describe '#words' do
      it 'returns a collection of words' do
        file = Tempfile.new 'dictionary_file'
        file.write "foo\nbar\nbaz\n"
        file.close

        words = Dictionary.new(file.path).words

        expect(words).to eq %w{ foo bar baz }
      end

      it 'does not return invalid lines' do
        file = Tempfile.new 'dictionary_file'
        file.write "   \nvalidline\n  \n\t\n \t\n"
        file.close

        words = Dictionary.new(file.path).words

        expect(words).to eq ['validline']
      end

      it 'raises an error if an empty dictionary is provided' do
        dictionary = Dictionary.new
        empty_dictionary = []
        File.stub(:readlines).and_return empty_dictionary

        expect { dictionary.words }.to raise_error EmptyDictionaryError
      end

      context 'a path to a non-existant dictionary was provided' do
        it 'raises an error' do
          expect { Dictionary.new('foo.bar.baz').words }.to raise_error(
            MissingDictionaryError)
        end
      end
    end
  end
end
