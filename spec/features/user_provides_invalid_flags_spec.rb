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
    it 'exits with exit code "64" and prints list of available algorithms' do
      executable = Executable.run('-a')

      expect(executable.exit_code).to eq 64

      error_lines = executable.error.split("\n")
      expect(error_lines[2]).to match(/please use one of the following algorithms:/i)
      expect(error_lines[3..-1]).to eq BlueCherries::AlgorithmFinder::ALGORITHMS.keys
    end
  end
end
