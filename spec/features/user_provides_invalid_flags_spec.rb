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
    it 'exits with exit code "64" and prints a list of available algorithms' do
      executable = Executable.run('-a')

      expect(executable.exit_code).to eq 64
      BlueCherries::AlgorithmFinder.default_instance.available_algorithms.each do |algorithm|
        expect(executable.error).to match(/#{algorithm}/)
      end
    end
  end
end
