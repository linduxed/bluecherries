require 'spec_helper'

module BlueCherries
  describe CommandLineOutput do
    context 'no arguments' do
      it 'returns the generated passwords' do
        sample_password = 'foobar'
        generator = double 'generator'
        generator.stub(:generate).and_return sample_password

        lines = CommandLineOutput.new(generator: generator).lines

        lines.each do |line|
          expect(line).to eq(sample_password)
        end
      end
    end
  end
end
