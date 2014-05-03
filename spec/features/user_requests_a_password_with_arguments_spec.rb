require 'spec_helper'

describe 'Requesting passwords' do
  context 'with non-standard length' do
    it 'returns passwords with at least provided length' do
      exec = Executable.run('-l 50')
      generated_passwords = exec.lines

      expect(generated_passwords).not_to be_empty
      generated_passwords.each do |password|
        expect(password).to be_longer_than(50)
      end
    end
  end

  context 'with both custom length and custom amount of passwords' do
    it 'returns the correct amount of passwords with right length' do
      generated_passwords = Executable.run('-l 50 -n 20').lines

      expect(generated_passwords).not_to be_empty
      expect(generated_passwords.count).to eq(20)
      generated_passwords.each do |password|
        expect(password).to be_longer_than(50)
      end
    end
  end
end
