require 'spec_helper'

describe Executable do
  describe '.run' do
    it 'returns an instance of Executable' do
      expect(Executable.run).to be_an Executable
    end
  end

  describe '#passwords' do
    it 'returns a list of strings' do
      passwords = Executable.run.passwords

      expect(passwords).not_to be_empty
      expect(passwords.all? { |p| p.class == String }).to be_true
    end
  end
end
