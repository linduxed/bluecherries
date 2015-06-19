require 'spec_helper'

module BlueCherries
  describe LayoutBasedDictionarySorter do
    describe '#sort' do
      it 'returns the words found in the provided dictionary' do
        dictionary = double(:dictionary, words: %w(foobar quuxbar))
        foo = double(:foo, value: 5, letters: 'foo')
        quux = double(:quux, value: 1, letters: 'quux')
        bar = double(:bar, value: 5, letters: 'bar')
        layout = double(:layout, motions: [foo, quux, bar])

        sorted_words = LayoutBasedDictionarySorter.new(dictionary, layout).sort

        expect(dictionary).to have_received(:words)
        expect(sorted_words).to match_array(dictionary.words)
      end
    end
  end

  describe MotionAnalyzedWord do
    describe '#to_s' do
      it 'returns the word provided upon instantiation' do
        word = MotionAnalyzedWord.new('foobar', double(:layout)).to_s

        expect(word).to eq('foobar')
      end
    end

    describe '#value' do
      it 'calculates the sum of the values of the motions of the word' do
        analyzed_word = 'foobar'
        foo = double(:foo, value: 5, letters: 'foo')
        quux = double(:quux, value: 1, letters: 'quux')
        bar = double(:bar, value: 5, letters: 'bar')
        layout = double(:layout, motions: [foo, quux, bar])

        value = MotionAnalyzedWord.new(analyzed_word, layout).value

        expect(layout).to have_received(:motions)
        expect(value).to eq(10)
      end

      it "raises an error if the available motions can't construct the word" do
        abc = double(:abc, value: 1, letters: 'abc')
        xyz = double(:xyz, value: 5, letters: 'xyz')
        layout = double(:layout, motions: [abc, xyz])

        expect do
          MotionAnalyzedWord.new('foobar', layout).value
        end.to raise_error(NonExhaustiveMotionSetError)
      end
    end
  end
end
