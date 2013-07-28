require 'spec_helper'

describe 'Requesting a password' do
  describe 'without any arguments' do
    let(:generated_passwords) { Executable.run.passwords }

    it 'returns passwords with a default format' do
      expect(generated_passwords).to have(6).items
      generated_passwords.each do |password|
        expect(password).to be_longer_than(15)
        expect(password).to have_camel_case
      end
    end
  end

  describe 'with a valid non-default algorithm argument' do
    let(:default_passwords) { Executable.run.passwords }
    let(:generated_passwords) { Executable.run('-a random').passwords }

    it 'returns a list of passwords' do
      expect(generated_passwords).to have(6).items
      expect(generated_passwords).not_to eq default_passwords
    end
  end
end
