require 'spec_helper'

describe Executable do
  describe '#lines' do
    it 'returns a list of strings' do
      lines = Executable.run.lines

      expect(lines).not_to be_empty
      expect(lines.all? { |p| p.class == String }).to be_true
    end
  end

  describe '#error' do
    it 'returns the error string' do
      error = Executable.run('-foo bar').error

      expect(error).to be_a String
    end
  end

  describe '#exit_code' do
    it 'returns an integer' do
      exit_code = Executable.run.exit_code

      expect(exit_code).to be_a Fixnum
    end
  end
end
