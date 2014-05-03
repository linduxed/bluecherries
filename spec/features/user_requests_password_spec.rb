require 'spec_helper'

describe 'Requesting a password' do
  context 'without any arguments' do
    it 'returns passwords with a default format' do
      generated_passwords = Executable.run.lines

      expect(generated_passwords).to have(6).items
      generated_passwords.each do |password|
        expect(password).to be_longer_than(15)
        expect(password).to have_camel_case
      end
    end
  end

  context 'with an invalid flag' do
    it 'exits with exit code "64" and prints an error message to $stderr' do
      executable = Executable.run('-foo someValidAlgorithm')

      expect(executable.exit_code).to eq 64
      expect(executable.error).to match(/invalid option/)
    end
  end
end
