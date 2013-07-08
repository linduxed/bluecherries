module BlueCherries
  class BadHandError < StandardError
  end

  class Key
    attr_reader :char, :hand, :row_number

    def initialize(char, hand, row_number)
      self.hand = hand
      @char = char
      @row_number = row_number
    end

    private

    def hand=(hand)
      if hand == :left || hand == :right
        @hand = hand
      else
        raise BadHandError
      end
    end
  end
end
