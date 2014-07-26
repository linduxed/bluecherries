guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/support/helpers/(.+)\.rb}) { |m| "spec/helpers/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }
end
