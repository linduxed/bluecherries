require 'spec_helper'

module BlueCherries
  describe CommandLineOutput do
    describe '#run' do
      it 'returns the output of the application' do
        sample_output = "firstPassword\nsecondPassword"
        generator = double 'generator'
        generator.stub(:generate).and_return sample_output
        orig_stdout = $stdout
        $stdout = StringIO.new

        CommandLineOutput.new(generator: generator).run

        expect($stdout.string).to match sample_output

        $stdout = orig_stdout
      end

      context 'an error is raised' do
        it 'exits with exit code "1" and prints an error message to $stderr' do
          generator = double 'password generator'
          generator.stub(:generate).and_raise RuntimeError
          orig_stderr = $stderr
          $stderr = StringIO.new

          expect { CommandLineOutput.new(generator: generator).run }.to(
            terminate.with_code 1)
          expect($stderr.string).to have_error_message('RuntimeError')

          $stderr = orig_stderr
        end
      end
    end
  end
end
