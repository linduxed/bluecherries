require 'spec_helper'

module BlueCherries
  describe TypeableAlgorithm do
    describe '#create_password_components' do
      it 'respects the minimum length' do
        dictionary = double('dictionary', words: %w{ foo bar baz })
        min_length = 7
        algorithm = TypeableAlgorithm.new(dictionary, min_length)

        password_components = algorithm.create_password_components

        expect(password_components.join.length).to be >= min_length
      end

      it 'gives different components for different keyboard layouts'
    end
  end
end
