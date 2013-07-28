require 'spec_helper'

describe Executable do
  describe '.run' do
    it 'returns an instance of Executable' do
      expect(Executable.run).to be_an Executable
    end
  end

  describe '#lines' do
    it 'returns a list of strings' do
      lines = Executable.run.lines

      expect(lines).not_to be_empty
      expect(lines.all? { |p| p.class == String }).to be_true
    end
  end
end
