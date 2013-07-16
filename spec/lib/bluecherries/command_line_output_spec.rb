require 'spec_helper'

module BlueCherries
  describe CommandLineOutput do
    describe '#run' do
      it 'returns the output of the application' do
        output_generator = CommandLineOutput.new
        sample_output = "firstPassword\nsecondPassword"
        output_generator.stub(:run).and_return sample_output

        expect(output_generator.run).to eq sample_output
      end

      context 'an error is raised' do
        it 'exits with exit code "1" and prints an error message to $stderr' do
          generator = double 'password generator'
          generator.stub(:generate).and_raise RuntimeError
          orig_stderr = $stderr
          $stderr = StringIO.new

          expect { CommandLineOutput.new(generator).run }.to(
            terminate.with_code 1)
          expect($stderr.string).to have_error_message('RuntimeError')

          $stderr = orig_stderr
        end
      end
    end
  end
end
