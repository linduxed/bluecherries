require 'rspec/expectations'

extend RSpec::Matchers::DSL

matcher :terminate do
  actual = nil

  match do |block|
    begin
      block.call
    rescue SystemExit => e
      actual = e.status
    end
    actual and actual == status_code
  end

  chain :with_code do |status_code|
    @status_code = status_code
  end

  failure_message_for_should do |block|
    "expected block to call exit(#{status_code}) but exit" +
      (actual.nil? ? " not called" : "(#{actual}) was called")
  end

  failure_message_for_should_not do |block|
    "expected block not to call exit(#{status_code})"
  end

  description do
    "expect block to call exit(#{status_code})"
  end

  def status_code
    @status_code ||= 0
  end
end
