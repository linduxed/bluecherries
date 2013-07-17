require 'spec_helper'

module BlueCherries
  describe PasswordGenerator do
    describe '#generate' do
      it 'returns a Password' do
        dictionary = Dictionary.new
        dictionary.stub(:words).and_return %w{ foo bar baz }
        min_length = 1
        algorithm = HeadAlgorithm.new dictionary, min_length

        password = PasswordGenerator.new.generate(algorithm)

        expect(password).to be_a Password
      end
    end
  end
end
