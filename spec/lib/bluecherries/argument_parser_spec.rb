require 'spec_helper'

describe ArgumentParser do
  describe '#parse' do
    describe 'flags' do
      it 'adds amount_of_passwords to the output hash for the "-n" flag' do
        args = %w[-n 3]
        empty_options = {}
        expected_hash = { amount_of_passwords: 3 }

        parsed_arguments = ArgumentParser.new(args, empty_options).parse

        expect(parsed_arguments).to eq(expected_hash)
      end

      it 'adds amount_of_passwords to the output hash for the "-n" flag' do
        args = %w[-n 3]
        empty_options = {}
        expected_hash = { amount_of_passwords: 3 }

        parsed_arguments = ArgumentParser.new(args, empty_options).parse

        expect(parsed_arguments).to eq(expected_hash)
      end
    end

    it 'returns the options hash unmodified if no arguments are provided' do
      empty_args = []
      input_options = { foo: 'foo', bar: 'bar' }

      parsed_options = ArgumentParser.new(empty_args, input_options).parse

      expect(parsed_options).to eq(input_options)
    end

    it 'parses arguments and merges with options' do
      input_args = %w[-n 3]
      input_options = { min_password_length: 10 }
      merged_hash = { amount_of_passwords: 3, min_password_length: 10 }

      resulting_hash = ArgumentParser.new(input_args, input_options).parse

      expect(resulting_hash).to eq(merged_hash)
    end

    it 'merges arguments with options, but lets options take precedence' do
      input_args = %w[-n 10]
      input_options = { amount_of_passwords: 3 }

      resulting_hash = ArgumentParser.new(input_args, input_options).parse

      expect(resulting_hash).to eq({ amount_of_passwords: 3 })
    end

    it 'prints a usage message if an invalid option is provided' do
      bad_args = %w[-foo bar]
      empty_options = {}
      orig_stderr = $stderr
      $stderr = StringIO.new

      expect do
        ArgumentParser.new(bad_args, empty_options).parse
      end.to terminate.with_code(64)

      expect($stderr.string).to have_error_message('invalid option')
      expect($stderr.string).to match(/Usage:/)

      $stderr = orig_stderr
    end
  end
end
