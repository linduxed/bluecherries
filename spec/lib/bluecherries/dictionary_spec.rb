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
        processed_dictionary = %w{ foo bar baz }
        File.stub(:readlines).and_return processed_dictionary
        words = Dictionary.new.words

        expect(words).to eq %w{ foo bar baz }
      end

      it 'does not return invalid lines' do
        dictionary = Dictionary.new

        dictionary.words.each do |word|
          word.should_not be_nil
          word.should_not be_empty
        end
      end

      it 'raises an error if an empty dictionary is provided' do
        dictionary = Dictionary.new
        empty_dictionary = []
        File.stub(:readlines).and_return empty_dictionary

        expect { dictionary.words }.to raise_error EmptyDictionaryError
      end

      context 'a non-existant dictionary was provided upon instantiation' do
        it 'raises an error' do
          File.stub(:open) { raise Errno::ENOENT }

          expect { Dictionary.new(:foobar).words }.to raise_error(
            MissingDictionaryError)
        end
      end
    end
  end
end
