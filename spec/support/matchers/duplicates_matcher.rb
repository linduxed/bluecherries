RSpec::Matchers.define :have_duplicates do
  match do |passwords|
    passwords.uniq != passwords
  end
end
