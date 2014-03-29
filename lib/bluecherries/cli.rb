module BlueCherries
  # Handles command line arguments and command line output.
  class CLI
    def run
      $stdout.puts CommandLineOutput.new.lines
    rescue => error
      $stderr.puts "ERROR: #{error.class} -- #{error.message}"
      exit 1
    end
  end
end
