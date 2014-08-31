require 'spec_helper'

module BlueCherries
  describe TypeableAlgorithm do
    describe '#create_password_components' do
      it 'respects the minimum length' do
        dictionary = double('dictionary', words: %w{ foo bar baz })
        layout = double(:layout)
        min_length = 7
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
        dictionary = Tempfile.new 'dictionary_file'
        dictionary.write(qwerty_word + "\n" + colemak_word + "\n")
        dictionary.close

        qwerty_components = TypeableAlgorithm.new(dictionary, min_length,
          qwerty_layout).create_password_components
        colemak_components = TypeableAlgorithm.new(dictionary, min_length,
          colemak_layout).create_password_components

        expect(qwerty_components).not_to eq(colemak_components)
      end
    end
  end
end
