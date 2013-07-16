def silence_stdout_and_stderr
  @orig_stderr = $stderr
  @orig_stdout = $stdout

  $stderr = File.new('/dev/null', 'w')
  $stdout = File.new('/dev/null', 'w')
end

def unsilence_stdout_and_stderr
  $stderr = @orig_stderr
  $stdout = @orig_stdout

  @orig_stderr = nil
  @orig_stdout = nil
end
