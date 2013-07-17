RSpec::Matchers.define :have_error_message do |message|
  match do |actual|
    actual =~ /^ERROR: .*#{Regexp.quote message}/
  end
end
