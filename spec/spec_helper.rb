require 'bluecherries'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  # Silence stderr and stdout
  original_stderr = $stderr
  original_stdout = $stdout

  config.before(:all) do
    $stderr = File.new('/dev/null', 'w')
    $stdout = File.new('/dev/null', 'w')
  end
  config.after(:all) do
    $stderr = original_stderr
    $stdout = original_stdout
  end
end
