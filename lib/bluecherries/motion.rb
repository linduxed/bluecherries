# Defines the different motions that one can do with one hand that result in
# a sequence of pressed keys.
class Motion
  attr_reader :keys

  def initialize(keys)
    @keys = keys
  end
end
