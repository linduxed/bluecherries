require 'spec_helper'

module BlueCherries
  describe TypeableAlgorithm do
    describe '#create_password_components' do
      it 'respects the minimum length' do
        dictionary = double('dictionary', words: %w{ foo bar baz })
        layout = double(:layout)
        min_length = 7
        sorter = double(:sorter, sort: %w[ foo bar baz ])
        allow(LayoutBasedDictionarySorter).to receive(:new).and_return(sorter)

        algorithm = TypeableAlgorithm.new(dictionary, min_length, layout)
        password_components = algorithm.create_password_components

        expect(password_components.join.length).to be >= min_length
      end

      it 'gives different components for different keyboard layouts' do
        qwerty_word = 'asdfkj'
        colemak_word = 'arsten'
        qwerty_layout = double(:qwerty_layout)
        colemak_layout = double(:colemak_layout)
        min_length = qwerty_word.length - 1
        dictionary = double(:dictionary)

        allow(LayoutBasedDictionarySorter).to receive(:new).with(
          dictionary, qwerty_layout).and_return(
          double(:qwerty_sorter, sort: [qwerty_word, colemak_word])
        )
        qwerty_components = TypeableAlgorithm.new(dictionary, min_length,
          qwerty_layout).create_password_components

        allow(LayoutBasedDictionarySorter).to receive(:new).with(
          dictionary, colemak_layout).and_return(
          double(:colemak_sorter, sort: [colemak_word, qwerty_word])
        )
        colemak_components = TypeableAlgorithm.new(dictionary, min_length,
          colemak_layout).create_password_components

        expect(qwerty_components).not_to eq(colemak_components)
      end
    end
  end
end
