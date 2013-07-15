require 'spec_helper'

module BlueCherries
  describe PasswordGenerator do
    describe '#generate' do
      it 'raises an error if an empty dictionary is provided' do
        algorithm = stub 'algorithm'
        dictionary = Dictionary.new
        dictionary.stub(:words).and_return []
        min_length = 1

        expect do
          PasswordGenerator.new.generate algorithm, dictionary, min_length
        end.to raise_error BlueCherries::EmptyDictionaryError
      end

      it 'returns a Password' do
        dictionary = Dictionary.new
        dictionary.stub(:words).and_return %w{ foo bar baz }
        algorithm = HeadAlgorithm.new
        min_length = 1

        password = PasswordGenerator.new.generate algorithm, dictionary,
          min_length

        expect(password).to be_a Password
      end
    end
  end
end
