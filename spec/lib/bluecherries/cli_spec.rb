require 'spec_helper'

module BlueCherries
  describe CLI do
    describe '#run' do
      it 'returns a list of strings' do
        with_stubbed_stdout do
          output_text = "firstPassword\nsecondPassword"
          output_generator = double('output_generator', lines: output_text)
          CommandLineOutput.stub(:new).and_return(output_generator)
          empty_args = []

          CLI.new(args: empty_args).run

          expect($stdout.string).to match(output_text)
        end
      end

      it 'forwards arguments to a parser' do
        with_stubbed_stdout do
          parser = double(parse: {})
          ArgumentParser.stub(:new).and_return(parser)
          input_args = %w[-n 3]

          CLI.new({ args: input_args }).run

          expect(ArgumentParser).to have_received(:new).with(input_args)
        end
      end

      it 'forwards a provided options-hash to the output generator' do
        with_stubbed_stdout do
          silent_output = double('silent_output')
          silent_output.stub(:lines)
          empty_args = []
          args_and_options = { args: empty_args, foo: 'foo' }
          CommandLineOutput.stub(:new).and_return(silent_output)

          CLI.new(args_and_options).run

          expect(CommandLineOutput).to have_received(:new).with({ foo: 'foo' })
        end
      end

      context 'both arguments and options are provided' do
        it 'merges opts and args then forwards the result' do
          with_stubbed_stdout do
            parsed_args = { amount_of_passwords: 3 }
            parser = double('arg_parser', parse: parsed_args)
            ArgumentParser.stub(:new).and_return(parser)
            silent_output = double('silent_output')
            silent_output.stub(:lines)
            CommandLineOutput.stub(:new).and_return(silent_output)

            CLI.new(args: 'stubbed', min_password_length: 10).run

            merged_options = { min_password_length: 10, amount_of_passwords: 3 }
            expect(CommandLineOutput).to have_received(:new).with(merged_options)
          end
        end

        it 'merges opts and args, but lets options take precedence' do
          with_stubbed_stdout do
            parsed_args = { amount_of_passwords: 3 }
            parser = double('arg_parser', parse: parsed_args)
            ArgumentParser.stub(:new).and_return(parser)
            silent_output = double('silent_output')
            silent_output.stub(:lines)
            CommandLineOutput.stub(:new).and_return(silent_output)

            CLI.new({
              args: 'whatever parses into { amount_of_passwords: 3 }',
              amount_of_passwords: 10,
              min_password_length: 10
            }).run

            merged_options = { min_password_length: 10, amount_of_passwords: 10 }
            expect(CommandLineOutput).to have_received(:new).with(merged_options)
          end
        end
      end

      context 'an error is raised' do
        it 'exits with exit code "1" and prints an error message to $stderr' do
          with_stubbed_stderr do
            output_generator = double 'output generator'
            output_generator.stub(:lines).and_raise RuntimeError
            CommandLineOutput.stub(:new).and_return(output_generator)
            empty_args = []

            expect { CLI.new(args: empty_args).run }.to terminate.with_code(1)
            expect($stderr.string).to have_error_message('RuntimeError')
          end
        end
      end
    end
  end
end
