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
        words = Dictionary.new.words

        expect(words[0]).to be_a String
      end

      it 'does not return invalid lines' do
        dictionary = Dictionary.new

        dictionary.words.each do |word|
          word.should_not be_nil
          word.should_not be_empty
        end
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
