require 'spec_helper'

module BlueCherries
  describe Dictionary do
    describe '.new' do
      it 'has default values' do
        expect { Dictionary.new }.not_to raise_error
      end

      it 'does not include invalid lines' do
        dictionary = Dictionary.new

        dictionary.words.each do |word|
          word.should_not be_nil
          word.should_not be_empty
        end
      end

      context 'a non-existant dictionary is provided' do
        it 'raises an error' do
          File.stub(:open) { raise Errno::ENOENT }

          expect { Dictionary.new(:foobar) }.to raise_error(
            MissingDictionaryError)
        end
      end
    end

    describe '#words' do
      it 'returns a collection of words' do
        words = Dictionary.new.words

        expect(words[0]).to be_a String
      end
    end
  end
end
