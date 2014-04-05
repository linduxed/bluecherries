require 'spec_helper'

module BlueCherries
  describe CLI do
    describe '#run' do
      it 'returns a list of strings' do
        output_text = "firstPassword\nsecondPassword"
        output_generator = double('output_generator', lines: output_text)
        CommandLineOutput.stub(:new).and_return(output_generator)
        orig_stdout = $stdout
        $stdout = StringIO.new
        empty_args = []

        CLI.new(args: empty_args).run

        expect($stdout.string).to match(output_text)

        $stdout = orig_stdout
      end

      context 'an error is raised' do
        it 'exits with exit code "1" and prints an error message to $stderr' do
          output_generator = double 'output generator'
          output_generator.stub(:lines).and_raise RuntimeError
          CommandLineOutput.stub(:new).and_return(output_generator)
          orig_stderr = $stderr
          $stderr = StringIO.new
          empty_args = []

          expect { CLI.new(args: empty_args).run }.to terminate.with_code(1)
          expect($stderr.string).to have_error_message('RuntimeError')

          $stderr = orig_stderr
        end
      end
    end
  end
end
