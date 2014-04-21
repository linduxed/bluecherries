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
end
