RSpec::Matchers.define :include_words_from do |words|
  match do |password|
    words.map(&:downcase).any? { |word| password.downcase =~ /#{word}/ }
  end
end
