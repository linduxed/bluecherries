require 'spec_helper'

describe 'Requesting typeable passwords' do
  context 'using the QWERTY layout with a polarized dictionary' do
    it 'returns passwords with only the highly typeable words' do
      low_typeability_words = %w(pzecuq yqmebigs mqoxht)
      high_typeability_words = %w(asdflkj qwerpoiu jklfds sdfjkl oiurew)
      all_words = (low_typeability_words + high_typeability_words).join("\n")
      dictionary = Tempfile.new 'dictionary_file'
      dictionary.write(all_words + "\n")
      dictionary.close

      executable = Executable.run("-a typeable -d #{dictionary.path} -l qwerty")
      generated_passwords = executable.lines

      expect(executable.error).to be_empty, "Error:\n#{executable.error}"
      generated_passwords.each do |password|
        expect(password).to include_words_from(high_typeability_words)
        expect(password).not_to include_words_from(low_typeability_words)
      end
      expect(generated_passwords).not_to have_duplicates
    end
  end
end
