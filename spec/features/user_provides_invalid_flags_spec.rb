require 'spec_helper'

describe 'Requesting a password' do
  context 'with an invalid flag' do
    it 'exits with exit code "64" and prints an error message to $stderr' do
      executable = Executable.run('-foo someValidAlgorithm')

      expect(executable.exit_code).to eq 64
      expect(executable.error).to match(/invalid option/)
    end
  end

  context 'with -a flag without an algorithm' do
    algorithm_list = %w[foobar bazquux banana]
    AlgorithmFinder.stub(:available_algorithms).and_return(algorithm_list)

    executable = Executable.run('-a')

    expect(executable.exit_code).to eq 64
    algorithm_list.each do |algorithm_name|
      expect(executable.error).to match(/#{algorithm_name}/)
    end
  end
end
