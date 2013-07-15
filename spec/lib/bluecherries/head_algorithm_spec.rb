require 'spec_helper'

module BlueCherries
  describe HeadAlgorithm do
    describe '#create_password_components' do
      let(:dictionary) { Dictionary.new }
      let(:algorithm) { HeadAlgorithm.new }
      before { dictionary.stub(:words).and_return %w{ foo bar baz } }

      it 'returns the first words of the dictionary' do
        min_length = 7

        password_components = algorithm.create_password_components(
          dictionary, min_length)

        expect(password_components).to eq dictionary.words
      end

      it 'respects the minimum length' do
        min_length = 7

        password_components = algorithm.create_password_components(
          dictionary, min_length)

        expect(password_components.join.length).to be >= min_length
      end

      it 'repeats the last word if the total dictionary length is too short' do
        min_length = 10

        password_components = algorithm.create_password_components(
          dictionary, min_length)

        expect(password_components[-1]).to eq password_components[-2]
      end
    end
  end
end
