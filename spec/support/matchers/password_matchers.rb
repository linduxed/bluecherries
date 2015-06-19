RSpec::Matchers.define :be_longer_than do |length|
  match do |password|
    password.length > length
  end
end

RSpec::Matchers.define :have_camel_case do
  match do |password|
    password =~ /^[a-z]+([A-Z][a-z]+)+$/
  end
end
