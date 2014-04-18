require 'spec_helper'

module BlueCherries
  describe RandomAlgorithm do
    describe '#create_password_components' do
      it 'respects the minimum length' do
        dictionary = double('dictionary', words: %w{ foo bar baz })
        min_length = 10
        algorithm = RandomAlgorithm.new(dictionary, min_length)

        password_components = algorithm.create_password_components

        expect(password_components.join.length).to be >= min_length
      end

      it 'is nondeterministic' do
        dictionary = double('dictionary', words: %w{ foo bar baz })
        min_length = 10
        algorithm = RandomAlgorithm.new(dictionary, min_length)

        srand 1
        first_set_of_components = algorithm.create_password_components
        srand 2
        second_set_of_components = algorithm.create_password_components

        expect(first_set_of_components).not_to eq(second_set_of_components)
      end

      it 'does not transform the words from the dictionary' do
        dictionary = double('dictionary', words: %w{ foo bar baz })
        min_length = 10
        algorithm = RandomAlgorithm.new(dictionary, min_length)

        password_components = algorithm.create_password_components

        password_components.each do |component|
          expect(dictionary.words).to include(component)
        end
      end
    end
  end
end
