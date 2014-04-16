require 'spec_helper'

describe ArgumentParser do
  describe '#parse' do
    describe 'flags' do
      it 'adds amount_of_passwords to the output hash for the "-n" flag' do
        args = %w[-n 3]
        expected_hash = { amount_of_passwords: 3 }

        parsed_arguments = ArgumentParser.new(args).parse

        expect(parsed_arguments).to eq(expected_hash)
      end

      it 'adds amount_of_passwords to the output hash for the "-n" flag' do
        args = %w[-n 3]
        expected_hash = { amount_of_passwords: 3 }

        parsed_arguments = ArgumentParser.new(args).parse

        expect(parsed_arguments).to eq(expected_hash)
      end
    end

    it 'prints a usage message if an invalid option is provided' do
      with_stubbed_stderr do
        bad_args = %w[-foo bar]

        expect do
          ArgumentParser.new(bad_args).parse
        end.to terminate.with_code(64)

        expect($stderr.string).to have_error_message('invalid option')
        expect($stderr.string).to match(/Usage:/)
      end
    end
  end
end
