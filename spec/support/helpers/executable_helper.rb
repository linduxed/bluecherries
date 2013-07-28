class Executable
  def initialize(args_string = '')
    @args_string = args_string
  end

  def passwords
    raw_output.readlines.map(&:chomp)
  end

  private

  def raw_output
    IO.popen(binary_location + " " + @args_string)
  end

  def binary_location
    File.expand_path('../../../../bin/bluecherries', __FILE__)
  end
end

class << Executable
  alias run new
end
