require 'spec_helper'

module BlueCherries
  describe HeadAlgorithm do
    describe '#create_password_components' do
      it 'returns the first words of the dictionary' do
        dictionary = double('dictionary', words: %w(foo bar baz))
        min_password_length = 7
        algorithm = HeadAlgorithm.new(
          dictionary: dictionary,
          min_password_length: min_password_length
        )

        password_components = algorithm.create_password_components

        expect(password_components).to eq(dictionary.words)
      end

      it 'respects the minimum length' do
        dictionary = double('dictionary', words: %w(foo bar baz))
        min_password_length = 7
        algorithm = HeadAlgorithm.new(
          dictionary: dictionary,
          min_password_length: min_password_length
        )

        password_components = algorithm.create_password_components

        expect(password_components.join.length).to be >= min_password_length
      end

      it 'repeats the last word if the total dictionary length is too short' do
        dictionary = double('dictionary', words: %w(foo bar baz))
        min_password_length = 10
        algorithm = HeadAlgorithm.new(
          dictionary: dictionary,
          min_password_length: min_password_length
        )

        password_components = algorithm.create_password_components

        expect(password_components[-1]).to eq(password_components[-2])
      end
    end
  end
end
