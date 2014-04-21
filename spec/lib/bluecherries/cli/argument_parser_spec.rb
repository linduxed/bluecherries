require 'spec_helper'

module BlueCherries
  describe ArgumentParser do
    describe '#parse' do
      describe 'flags' do
        it 'adds amount_of_passwords to the output hash for the "-n" flag' do
          args = %w[-n 3]
          expected_hash = { amount_of_passwords: 3 }

          parsed_arguments = ArgumentParser.new(args).parse

          expect(parsed_arguments).to eq(expected_hash)
        end

        it 'adds min_password_length to the output hash for the "-l" flag' do
          args = %w[-l 20]
          expected_hash = { min_password_length: 20 }

          parsed_arguments = ArgumentParser.new(args).parse

          expect(parsed_arguments).to eq(expected_hash)
        end

        it 'adds dictionary_path to the output hash for the "-d" flag' do
          file = Tempfile.new 'dictionary_file'
          file.write "foo\nbar\nbaz\n"
          file.close
          args = ['-d', file.path]
          expected_hash = { dictionary_path: file.path }

          parsed_arguments = ArgumentParser.new(args).parse

          expect(parsed_arguments).to eq(expected_hash)
        end

        it 'adds algorithm_kind to the output hash for the "-a" flag' do
          class FoobarAlgorithm; end
          args = %w[-a foobar]
          expected_hash = { algorithm_kind: FoobarAlgorithm }

          parsed_arguments = ArgumentParser.new(args).parse

          expect(parsed_arguments).to eq(expected_hash)

          BlueCherries.send(:remove_const, :FoobarAlgorithm)
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
end
