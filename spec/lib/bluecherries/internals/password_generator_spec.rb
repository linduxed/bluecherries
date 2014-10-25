require 'spec_helper'

module BlueCherries
  describe PasswordGenerator do
    describe '#generate' do
      it 'returns a Password' do
        dictionary = Dictionary.new
        allow(dictionary).to receive(:words).and_return %w{ foo bar baz }
        min_password_length = 1
        algorithm = HeadAlgorithm.new dictionary, min_password_length

        password = PasswordGenerator.new.generate(algorithm)

        expect(password).to be_a Password
      end
    end
  end
end
