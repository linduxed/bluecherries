require 'spec_helper'

module BlueCherries
  describe ArgumentParser do
    around(:example) do |example|
      with_stubbed_stderr(&example)
    end

    describe '#parse' do
      describe 'flags' do
        it 'adds amount_of_passwords to the output hash for the "-n" flag' do
          args = %w[-n 3]
          expected_hash = { amount_of_passwords: 3 }

          parsed_arguments = ArgumentParser.new(args).parse

          expect(parsed_arguments).to eq(expected_hash)
        end

        describe '"-c"' do
          it 'adds min_password_length to the output hash' do
            args = %w[-c 20]
            expected_hash = { min_password_length: 20 }

            parsed_arguments = ArgumentParser.new(args).parse

            expect(parsed_arguments).to eq(expected_hash)
          end

          it 'does not accept zero as a length' do
            args = %w[-c 0]

            expect do
              ArgumentParser.new(args).parse
            end.to raise_error(OptionParser::InvalidArgument)

            expect($stderr.string).to match(/Usage:/)
          end
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

        describe '"-a"' do
          it 'adds algorithm_kind to the output hash' do
            args = %w[-a foobar]
            foobar_algorithm = double('foobar_algorithm')
            algorithm_finder = double('alg_finder', find: foobar_algorithm)
            allow(AlgorithmFinder).to receive(:new).and_return(algorithm_finder)
            expected_hash = { algorithm_kind: foobar_algorithm }

            parsed_arguments = ArgumentParser.new(args).parse

            expect(AlgorithmFinder).to have_received(:new).with('foobar')
            expect(parsed_arguments).to eq(expected_hash)
          end

          it 'requires an argument' do
            args = ['-a']

            expect do
              ArgumentParser.new(args).parse
            end.to raise_error(OptionParser::MissingArgument)

            expect($stderr.string).to match(/Usage:/)
          end
        end
      end

      it 'prints a usage message if an invalid option is provided' do
        bad_args = %w[-foo bar]

        expect do
          ArgumentParser.new(bad_args).parse
        end.to raise_error(OptionParser::InvalidOption)

        expect($stderr.string).to match(/Usage:/)
      end
    end
  end
end
