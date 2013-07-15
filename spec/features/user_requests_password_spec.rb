require 'spec_helper'

describe 'Requesting a password' do
  describe 'without any arguments' do
    let(:generated_passwords) { run_app.readlines.map(&:chomp) }

    it 'returns passwords with a default format' do
      expect(generated_passwords).to have(6).items
      generated_passwords.each do |password|
        expect(password).to be_longer_than(15)
        expect(password).to have_camel_case
      end
    end

    def run_app
      IO.popen(File.expand_path('../../../bin/bluecherries', __FILE__))
    end
  end
end
